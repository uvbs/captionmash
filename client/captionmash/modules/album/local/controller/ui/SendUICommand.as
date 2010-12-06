package com.captionmashup.modules.album.local.controller.ui
{
	import com.captionmashup.common.pipe.message.album.LocalAlbumMessage;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	import com.captionmashup.modules.album.local.view.BrowserMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class SendUICommand extends SimpleCommand
	{
		private var localAlbumMessage:LocalAlbumMessage;
		private var browserMediator:BrowserMediator;
		
		override public function execute(notification:INotification):void{
			browserMediator = facade.retrieveMediator(BrowserMediator.NAME) as BrowserMediator;
			localAlbumMessage = new LocalAlbumMessage(LocalAlbumMessage.SET_UI,browserMediator.browser);
			
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,localAlbumMessage);
		}
	}
}