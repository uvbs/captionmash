package com.captionmashup.common.model.proxy.FrameProxy
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	import com.captionmashup.common.model.local.vo.Frame.Frame;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.creator.facade.ApplicationConstants;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.LoaderContext;
	
	import mx.collections.ArrayCollection;
	
	import org.hamcrest.mxml.collection.InArray;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class AbstractFrameProxy extends Proxy implements IFrameProxy
	{
		protected var index:int;		//ActiveIndex
		public var bulkLoader:BulkLoader;
		protected var tempFrame:Frame;	//temp frame that holds frame data while image is loading
		protected var tempIndex:int; 	//temp index that holds insert index while image is loading
		private var loaderContext:LoaderContext;
		
		public function AbstractFrameProxy(proxyName:String=null)
		{
			super(proxyName, new ArrayCollection);
			loaderContext = new LoaderContext();
			loaderContext.checkPolicyFile = true; 
				
			bulkLoader = new BulkLoader(super.proxyName+"frames",
								BulkLoader.DEFAULT_NUM_CONNECTIONS,
								BulkLoader.LOG_VERBOSE);		
		}
		
		override public function onRemove():void{
			bulkLoader.removeAll();
			bulkLoader.clear();
		}
		
		public function set frames(source:ArrayCollection):void
		{	
			if(source == null || source.length == 0){
				this.data = new ArrayCollection;
				sendEmptyFrames();
				return;
			} 
			
			this.data = source;
			bulkLoader.removeAll();
			loadBitmapData(source);
			
			index = 0;
		}
		
		public function get frames():ArrayCollection
		{
			return this.data as ArrayCollection;
		}

		private function loadBitmapData(source:ArrayCollection):void{

			for (var i:int = 0; i < source.length; i++)
			{
				bulkLoader.add( Frame(source.getItemAt(i)).photo.photo_path,
								{ id:"photo-"+i,context: loaderContext});	
			}
			bulkLoader.addEventListener(BulkProgressEvent.COMPLETE,onFramesReady);
			bulkLoader.addEventListener(BulkProgressEvent.PROGRESS,onProgress);
			bulkLoader.start();
		}
		
		private function onFramesReady(evt:BulkProgressEvent):void
		{
			trace("onFramesReady called in AbstractFrameProxy");
			for(var i:int = 0; i < frames.length; i++)
			{	
				var bitmapData:BitmapData = bulkLoader.getBitmapData("photo-"+i);
				Frame(frames.getItemAt(i)).bitmapData = bitmapData;
			}
			bulkLoader.removeEventListener(BulkProgressEvent.PROGRESS,onProgress);
			bulkLoader.removeEventListener(BulkProgressEvent.COMPLETE,onFramesReady);
			sendFrames();
			sendActiveFrame();
			
		}
		
		public function set activeIndex(value:int):void
		{
			if(value < 0) throw new Error ("Active index cannot be less than zero");
			if(value > frames.length-1) throw new Error ("Active index cannot be greater than frames.length-1");
			index = value;
			sendActiveFrame();
		}
		
		public function get activeIndex():int
		{
			return index;
		}
		
		public function get activeFrame():Frame{
			return frames[activeIndex] as Frame;
		}
		
		public function nextFrame():void
		{
			if(index + 1 < frames.length){
				index += 1;
				sendActiveFrame();
			}
		}
		
		public function prevFrame():void
		{
			if(index - 1 >= 0){
				index -= 1;
				sendActiveFrame();
			}
		}
		
		/***********************************************
		 * Methods for adding a frame
		 * 
		 * 1- Save parameters into temp variables
		 * 2- Load frame's bitmap data
		 * 3- Load and Write bitmap data into tempFrame
		 * 4- Insert tempFrame into frames
		 * 5- Send frames and activeFrame
		 * **********************************************/
		public function addFrame(frame:Frame,index:int=0):void{				
			trace("AbstractFrameProxy.addFrame called");
			//t.obj(frame,"Adding frame in AbstractFrameProxy.addFrame");
			tempFrame = frame;
			tempIndex = index;
			loadSinglePhoto(frame.photo.photo_path);
		}
		public function loadSinglePhoto(path:String):void{
			bulkLoader.add( path,{ id:"singlePhoto",context: loaderContext});
			bulkLoader.get("singlePhoto").addEventListener(BulkLoader.COMPLETE, onPhotoLoaded, false, 0, true);
			bulkLoader.get("singlePhoto").addEventListener(BulkLoader.ERROR, onPhotoError, false, 0, true);
			bulkLoader.start();
		}
		
		private function onPhotoLoaded(evt:Event):void{
			trace("single photo data loaded");
			evt.target.removeEventListener(BulkLoader.COMPLETE, onPhotoLoaded);
			var bitmapData:BitmapData = bulkLoader.getBitmapData("singlePhoto");
			bulkLoader.remove("singlePhoto");
			
			tempFrame.bitmapData = bitmapData;
			
			frames.addItemAt(tempFrame,tempIndex);
			activeIndex = tempIndex; //Sends frame notification
			sendFrames(); //Send all frames to frameSelectorMediator
			
			tempIndex = 0;
			tempFrame = null;
		}
		
		
		/***************************************
		 * Method for removing frame
		 * 
		 * 1- Remove frame at selected index 
		 * 2- If selected index is last element,
		 * 		set activeIndex--
		 * **************************************/
		public function removeFrame(removeIndex:int):void
		{
			if(removeIndex < 0 || removeIndex >= frames.length || frames.length == 0){
				trace("remove index out of bounds, index:"+removeIndex );
				trace("activeIndex: "+activeIndex);
				trace("frames.length: "+frames.length);
				return;
			}
			//Last element
			if(removeIndex == frames.length-1){
				//If first and only element is removed
				activeIndex = activeIndex-1 < 0 ? 0 : activeIndex-1;
				frames.removeItemAt(removeIndex);
			} else {
				frames.removeItemAt(removeIndex);
				activeIndex = removeIndex;
			}
			if(frames.length == 0){
				sendEmptyFrames();
			}else{
				sendFrames();	
			}
		}

		private function onPhotoError(evt:Event):void{
			trace("SinglePhotoLoad error");
		}
		
		protected function onProgress(evt:BulkProgressEvent):void{
			throw new Error("onProgress function must be overridden to send a notification");
		}
		
		public function sendActiveFrame():void
		{
			throw new Error("sendActiveFrame function must be overridden to send a Notification");
		}
		
		public function sendFrames():void{
			throw new Error("sendFrames function must be overridden to send a Notification");
		}
		
		public function sendEmptyFrames():void{
			throw new Error("sendEmptyFrames function must be overridden to send a Notification");
		}
	}
}