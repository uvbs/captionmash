package com.captionmashup.modules.core.album_container.controller.ui.facebook
{
	import com.captionmashup.common.pipe.message.album.FacebookMessage;
	import com.captionmashup.modules.core.album_container.facade.ApplicationConstants;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class GetFacebookUICommand extends SimpleCommand
	{
		private var facebookMessage:FacebookMessage;
		override public function execute(notification:INotification):void{
			facebookMessage = new FacebookMessage(FacebookMessage.LOAD_MODULE);
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,facebookMessage);
		}
	}
}