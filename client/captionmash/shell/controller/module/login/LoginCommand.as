package com.captionmashup.shell.controller.module.login
{
	import com.captionmashup.common.pipe.message.core.LoginMessage;
	import com.captionmashup.shell.facade.ShellConstants;
	import com.captionmashup.shell.model.MessageProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class LoginCommand extends SimpleCommand
	{
		private var messageProxy:MessageProxy;
		override public function execute(notification:INotification):void
		{
			trace("LoginCommand command in shell called");
			
			//Store Message Here
			messageProxy = facade.retrieveProxy(MessageProxy.NAME) as MessageProxy;
			messageProxy.addMessage(notification.getBody() as LoginMessage);
			
			
			sendNotification(ShellConstants.SEND_MESSAGE_TO_MODULE,
				messageProxy.getLatestMessage(LoginMessage));
		}
	}
}