package com.captionmashup.modules.core.creator.controller.ui
{
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.modules.core.creator.facade.ApplicationConstants;
	import com.captionmashup.modules.core.creator.view.CreatorMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class SendUICommand extends SimpleCommand
	{
		
		private var creatorMessage:CreatorMessage;
		private var creatorMediator:CreatorMediator;
		override public function execute(notification:INotification):void{
			
			creatorMediator = facade.retrieveMediator(CreatorMediator.NAME) as CreatorMediator;
			creatorMessage = new CreatorMessage(CreatorMessage.SET_UI,creatorMediator.captionEditor);
			
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,creatorMessage);
		}
	}
}