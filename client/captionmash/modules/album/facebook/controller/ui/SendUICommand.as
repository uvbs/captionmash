package com.captionmashup.modules.album.facebook.controller.ui
{
	import com.captionmashup.common.pipe.message.album.FacebookMessage;
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.modules.album.facebook.view.AppScreenMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class SendUICommand extends SimpleCommand
	{
		private var appScreenMediator:AppScreenMediator;
		private var facebookMessage:FacebookMessage;
		
		override public function execute(notification:INotification):void{
			appScreenMediator = facade.retrieveMediator(AppScreenMediator.NAME) as AppScreenMediator;
			
			facebookMessage = new FacebookMessage(FacebookMessage.SET_UI,appScreenMediator.appScreen);
			
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,facebookMessage);
		}
	}
}