package com.captionmashup.modules.core.album_container.controller.ui
{
	import com.captionmashup.common.pipe.message.core.AlbumContainerMessage;
	import com.captionmashup.modules.core.album_container.facade.ApplicationConstants;
	import com.captionmashup.modules.core.album_container.view.AlbumMenuMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class SendUICommand extends SimpleCommand
	{
		private var albumMenuMediator:AlbumMenuMediator;
		private var albumContainerMessage:AlbumContainerMessage;
		override public function execute(notification:INotification):void{
			trace("AlbumContainerModule SendUICommand called");
			
			albumMenuMediator = facade.retrieveMediator(AlbumMenuMediator.NAME) as AlbumMenuMediator;
			albumContainerMessage = new AlbumContainerMessage(AlbumContainerMessage.SET_UI,
											albumMenuMediator.albumMenu);
			
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,albumContainerMessage);
		}
	}
}