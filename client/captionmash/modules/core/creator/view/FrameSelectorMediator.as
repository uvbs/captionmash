package com.captionmashup.modules.core.creator.view
{
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	import com.captionmashup.common.model.local.vo.Frame.Frame;
	import com.captionmashup.common.model.proxy.FrameProxy.IFrameProxy;
	import com.captionmashup.common.view.mediator.FrameSelectorMediator.AbstractFrameSelectorMediator;
	import com.captionmashup.common.view.mediator.FrameSelectorMediator.IFrameSelectorMediator;
	import com.captionmashup.modules.core.creator.facade.ApplicationConstants;
	import com.captionmashup.modules.core.creator.model.CreatorFrameProxy;
	import com.captionmashup.modules.core.creator.view.components.CaptionEditor.FrameSelector.ItemRenderer.CreatorFrameOverlay;
	import com.captionmashup.modules.core.creator.view.components.CaptionEditor.FrameSelector.ItemRenderer.CreatorFrameRenderer;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import spark.events.IndexChangeEvent;
	import spark.layouts.supportClasses.DropLocation;
	
	public class FrameSelectorMediator extends AbstractFrameSelectorMediator implements IFrameSelectorMediator
	{
		public static const NAME:String = "FrameSelectorMediator";
		public var lastInsertIndex:int = 0;
		
		public function FrameSelectorMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			//frameSelector.list.dragEnabled = true;
			
			//TODO handle frame swap
			//frameSelector.list.addEventListener(DragEvent.DRAG_START,onDragStart);
			
			frameSelector.list.addEventListener(DragEvent.DRAG_ENTER,onDragEnter);
			frameSelector.list.addEventListener(DragEvent.DRAG_DROP,onDragDrop);
			frameSelector.list.addEventListener(DragEvent.DRAG_OVER,onDragOver);
			
			frameSelector.list.itemRenderer = new ClassFactory(CreatorFrameRenderer);
			
			frameSelector.list.addEventListener(CreatorFrameOverlay.REMOVE_FRAME,onRemoveFrame);
			frameSelector.list.minHeight = 80;
		}
		
		override public function onRegister():void{
			frameProxy = facade.retrieveProxy(CreatorFrameProxy.NAME) as IFrameProxy;
		}

		/****************************
		 * Drag Drop Handlers
		 * **************************/
		private function onDragEnter(evt:DragEvent):void{
			DragManager.acceptDragDrop(evt.currentTarget as IUIComponent);
		}
		
		private function onDragOver(evt:DragEvent):void{
			var pos:DropLocation=frameSelector.list.layout.calculateDropLocation(evt);
			DragManager.showFeedback(DragManager.COPY);
			frameSelector.list.createDropIndicator();
			frameSelector.list.layout.showDropIndicator(pos);
		}
		
		private function onDragDrop(evt:DragEvent):void{
			var pos:DropLocation=frameSelector.list.layout.calculateDropLocation(evt);
			var items:Object=evt.dragSource.dataForFormat("itemsByIndex") as Object;
			var photoDTO:PhotoDTO = items[0] as PhotoDTO;
			//pos.dropIndex
			//Save insert index to be used by command
			lastInsertIndex = pos.dropIndex;
			
			//Create new frame with empty bitmapData to add
			var frame:Frame = new Frame(photoDTO);	
			sendNotification(ApplicationConstants.ADD_FRAME,frame);
		}
		
		//Swapping frames
		private function onDragStart(evt:DragEvent):void{
			trace("drag started");
		}
		
		override public function frameIndexChangeHandler(evt:IndexChangeEvent):void{
			trace("frameIndexChangeHandler override, index: "+frameSelector.list.selectedIndex);
			sendNotification(ApplicationConstants.SAVE_FRAME);
			super.frameIndexChangeHandler(evt);
		}
		
		override public function frameSelectorHandler(evt:Event):void{
			trace("frameSelectorHandler override");
			sendNotification(ApplicationConstants.SAVE_FRAME);
			super.frameSelectorHandler(evt);
		}
		
		private function onRemoveFrame(evt:Event):void{
			trace("evt target in onRemoveFrame: "+evt.target);
			sendNotification(ApplicationConstants.DELETE_FRAME,frameSelector.list.selectedIndex);
		}
		
		override public function listNotificationInterests():Array
		{ 
			return [
				ApplicationConstants.FRAMES_SET,
				ApplicationConstants.FRAMES_EMTPY,
				ApplicationConstants.START_PLAY,
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{	
			switch (notification.getName())
			{		
				case ApplicationConstants.FRAMES_SET:
					trace("Frames set in FrameSelectorMediator (creator)");
					updateFrames(notification.getBody() as ArrayCollection);	
					break;
				
				case ApplicationConstants.START_PLAY:
					//Save current frame before playing
					sendNotification(ApplicationConstants.SAVE_FRAME);
					play();
					break;
				
				case ApplicationConstants.FRAMES_EMTPY:
					trace("Frames empty in FrameSelectorHandler");
					clearFrames();
					break;
			}
		}//handleNotification end
	}
}