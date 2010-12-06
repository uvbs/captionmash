package com.captionmashup.modules.core.creator.model
{

	import br.com.stimuli.loading.BulkProgressEvent;
	
	import com.captionmashup.common.model.proxy.FrameProxy.AbstractFrameProxy;
	import com.captionmashup.common.model.proxy.FrameProxy.IFrameProxy;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.creator.facade.ApplicationConstants;
	
	import mx.collections.ArrayCollection;
	
	/************************************
	 * Holds and array of Frames
	 * 
	 * Array is serialized and written as
	 * data while creating a CaptionDTO
	 * **********************************/
	
	public class CreatorFrameProxy extends AbstractFrameProxy implements IFrameProxy
	{
		public static const NAME:String = "CreatorFrameProxy";
		public function CreatorFrameProxy()
		{
			super(NAME);
		}
		
		override public function sendActiveFrame():void{
			if(frames.length == 0) return;
			sendNotification(ApplicationConstants.FRAME_CHANGED, frames.getItemAt(activeIndex));
		}
		
		override public function sendFrames():void{
			sendNotification(ApplicationConstants.FRAMES_SET, frames);
		}
		
		override public function sendEmptyFrames():void{
			sendNotification(ApplicationConstants.FRAMES_EMTPY);
		}
		
		//Will be used to display loading feedback
		override protected function onProgress(evt:BulkProgressEvent):void{
			trace("creator progress event");
		}
	}
}