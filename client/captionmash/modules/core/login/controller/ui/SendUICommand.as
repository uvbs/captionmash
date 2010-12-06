package com.captionmashup.modules.core.login.controller.ui
{
	import com.captionmashup.common.pipe.message.core.LoginMessage;
	import com.captionmashup.modules.core.login.facade.ApplicationConstants;
	import com.captionmashup.modules.core.login.view.LoginBarMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class SendUICommand extends SimpleCommand
	{

		private var loginMessage:LoginMessage;
		private var loginBarMediator:LoginBarMediator;
		
		override public function execute(notification:INotification):void{
			
			loginBarMediator = facade.retrieveMediator(LoginBarMediator.NAME) as LoginBarMediator;
			loginMessage = new LoginMessage(LoginMessage.SET_UI,loginBarMediator.loginBar);
			
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,loginMessage);
		}
	}
}