package com.captionmashup.modules.album.local.controller.batch
{
	import com.captionmashup.common.pipe.message.core.BasketMessage;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	import com.captionmashup.modules.album.local.model.PhotoProxy;
	import com.captionmashup.modules.album.local.view.PhotoBrowserMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class BatchAddToBasketCommand extends SimpleCommand
	{
		private var photoProxy:PhotoProxy;
		private var photoBrowserMediator:PhotoBrowserMediator;
		private var basketMessage:BasketMessage;
		
		override public function execute(notification:INotification):void{
			photoProxy = facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;
			photoBrowserMediator = facade.retrieveMediator(PhotoBrowserMediator.NAME) as PhotoBrowserMediator;
			//basketMessage = new BasketMessage(BasketMessage.ADD_PHOTO,
			//photoBrowserMediator.photoBrowser.tileList.dataProvider
			t.obj(photoProxy.allRecords.source,"source in local album BatchAddToBasketCommand");
			basketMessage = new BasketMessage(BasketMessage.ADD_PHOTO,photoProxy.allRecords.source);
			
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,basketMessage);
		}
	}
}