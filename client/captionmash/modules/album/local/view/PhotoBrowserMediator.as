package com.captionmashup.modules.album.local.view
{
	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.model.proxy.PaginatorProxy.IPaginatorProxy;
	import com.captionmashup.common.view.component.SparkThumbnailTileList.PhotoBrowser.PhotoBrowser;
	import com.captionmashup.common.view.component.SparkThumbnailTileList.SparkThumbnailTileList;
	import com.captionmashup.common.view.mediator.PaginatorMediator.AbstractPhotoBrowserMediator;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	import com.captionmashup.modules.album.local.model.PhotoProxy;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;

	public class PhotoBrowserMediator extends AbstractPhotoBrowserMediator
	{
		
		public static const NAME:String = "PhotoBrowserMediator";
		
		public function PhotoBrowserMediator(viewComponent:SparkThumbnailTileList)
		{
			super(NAME, viewComponent);
			photoBrowser.setSize(ApplicationConstants.PHOTO_LIST_ROW_COUNT,
									ApplicationConstants.PHOTO_LIST_COLUMN_COUNT);
		}
		
		override public function onRegister():void{
			paginatorProxy = facade.retrieveProxy(PhotoProxy.NAME) as IPaginatorProxy;
		}
		
		override protected function sendMessageToShell(message:Message):void{
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,message);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.PHOTO_PAGINATOR_NOTIFICATION,
			];
		}
		
		override public function handleNotification(note:INotification):void
		{	
			switch (note.getName())
			{
				case ApplicationConstants.PHOTO_PAGINATOR_NOTIFICATION:
					updateSparkView(note.getBody() as PaginatorData,photoBrowser.tileList);
					break;	
			}
		}//handleNotification end
	}
}