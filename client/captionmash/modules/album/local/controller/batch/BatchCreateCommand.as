package com.captionmashup.modules.album.local.controller.batch
{
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	import com.captionmashup.modules.album.local.model.PhotoProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class BatchCreateCommand extends SimpleCommand
	{
		private var photoProxy:PhotoProxy;
		private var creatorMessage:CreatorMessage;

		override public function execute(notification:INotification):void{
			photoProxy = facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;
			
			creatorMessage = new CreatorMessage(CreatorMessage.START_CREATE,photoProxy.allRecords.source);
			
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,creatorMessage);
		}
	}
}