package com.captionmashup.modules.core.creator.controller.creation
{
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.modules.core.creator.facade.ApplicationConstants;
	import com.captionmashup.modules.core.creator.model.CreatorFrameProxy;
	import com.captionmashup.modules.core.creator.view.CreatorMediator;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class CancelCreationCommand extends SimpleCommand implements ICommand
	{
		private var creatorMediator:CreatorMediator;
		private var frameProxy:CreatorFrameProxy;
		
		override public function execute(notification:INotification):void
		{
			trace("CancelCreation called from Module: Creator");
			frameProxy = facade.retrieveProxy(CreatorFrameProxy.NAME) as CreatorFrameProxy;
			
			frameProxy.frames = null;
			creatorMediator = facade.retrieveMediator(CreatorMediator.NAME) as CreatorMediator;
			
			//Send viewComponent for display
			var popupMessage:PopupMessage = new PopupMessage(PopupMessage.REMOVE_POPUP,
				creatorMediator.captionEditor);
			
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,popupMessage);
			
			sendNotification( ApplicationConstants.SEND_MESSAGE_TO_SHELL,
								new CreatorMessage(CreatorMessage.END_CREATE));
			//sendNotification( ApplicationConstants.DISPOSE);
				
		}
	}
}