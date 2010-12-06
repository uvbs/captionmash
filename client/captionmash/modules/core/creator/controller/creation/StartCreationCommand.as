package com.captionmashup.modules.core.creator.controller.creation
{
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	import com.captionmashup.common.model.local.vo.Frame.Frame;
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.modules.core.creator.facade.ApplicationConstants;
	import com.captionmashup.modules.core.creator.model.CreatorFrameProxy;
	import com.captionmashup.modules.core.creator.view.CreatorMediator;
	import com.captionmashup.modules.core.creator.view.components.CaptionEditor.Editor;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class StartCreationCommand extends SimpleCommand implements ICommand
	{
		private var creatorMediator:CreatorMediator;
		private var frameProxy:CreatorFrameProxy;
		
		override public function execute(notification:INotification):void
		{
			trace("StartCreation from Creator called");	
			creatorMediator = facade.retrieveMediator(CreatorMediator.NAME) as CreatorMediator;
			frameProxy = facade.retrieveProxy(CreatorFrameProxy.NAME) as CreatorFrameProxy;
			
			var creatorMessage:CreatorMessage = notification.getBody() as CreatorMessage;
			
			//Handle flashvar action (photoLink,albumLink,templateLink)
			
			if(creatorMessage.getHeader() != null){
				switch(creatorMessage.getHeader()){
					case CreatorMessage.HEADER_PHOTO_LINK:
						trace("PHOTO LINK IN START CREATE COMMAND");
						sendNotification(ApplicationConstants.GET_SINGLE_PHOTO,creatorMessage.getBody());
						break;
					case CreatorMessage.HEADER_ALBUM_LINK:
						trace("ALBUM LINK IN START CREATE COMMAND");
						sendNotification(ApplicationConstants.GET_ALBUM_PHOTOS,creatorMessage.getBody());
						break;
					case CreatorMessage.HEADER_TEMPLATE_LINK:
						trace("TEMPLATE LINK IN START CREATE COMMAND");
						sendNotification(ApplicationConstants.GET_TEMPLATE_PHOTOS,creatorMessage.getBody());
						break;
				}
				return;
			}
			
			//Handle empty start
			if(creatorMessage.getBody() == null && frameProxy.frames.length == 0){	
				handleEmptyStart();
				return;
			} else if (creatorMessage.getBody() is PhotoDTO){
				handleSinglePhotoStart(creatorMessage.getBody() as PhotoDTO);
				return;
			} else if (creatorMessage.getBody() is Array){
				handleBatchPhotoStart(creatorMessage.getBody() as Array);
				return;
			}

		}
		
		private function handleEmptyStart():void{
			creatorMediator.captionEditor.editorControls.enabled= false;
			creatorMediator.captionEditor.overlay.emptyScreen.visible = true;
		}
		
		//Single photo
		private function handleSinglePhotoStart(photoDTO:PhotoDTO):void{

			//Handle initial images
			creatorMediator.captionEditor.overlay.enabled = true;
			creatorMediator.captionEditor.overlay.emptyScreen.visible = false;
			creatorMediator.displayProgressPopup();
			frameProxy.addFrame(new Frame(photoDTO));
		}
		
		//Batch photos
		private function handleBatchPhotoStart(source:Array):void{
			//Handle initial images
			creatorMediator.captionEditor.overlay.enabled = true;
			creatorMediator.captionEditor.overlay.emptyScreen.visible = false;
			creatorMediator.displayProgressPopup();
			
			var result:Array = new Array;
			var tempFrame:Frame;
			
			for each(var photoDTO:PhotoDTO in source){
				//frameProxy.addFrame(new Frame(photoDTO));
				tempFrame = new Frame(photoDTO);
				result.push(tempFrame);	
			}
			
			frameProxy.frames = new ArrayCollection(result);
		}
	}
}