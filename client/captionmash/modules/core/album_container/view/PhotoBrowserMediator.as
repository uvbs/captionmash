package com.captionmashup.modules.core.album_container.view
{
	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.model.proxy.PaginatorProxy.IPaginatorProxy;

	import com.captionmashup.common.view.component.SparkThumbnailTileList.SparkThumbnailTileList;

	import com.captionmashup.common.view.mediator.PaginatorMediator.AbstractPhotoBrowserMediator;
	import com.captionmashup.modules.core.album_container.facade.ApplicationConstants;
	import com.captionmashup.modules.core.album_container.model.PhotoProxy;
	
	import mx.core.ClassFactory;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class PhotoBrowserMediator extends AbstractPhotoBrowserMediator
	{
		public static const NAME:String = "PhotoBrowserMediator";
		
		public function PhotoBrowserMediator(viewComponent:SparkThumbnailTileList)
		{
			super(NAME, viewComponent);
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
					trace("Handling ALBUM_PAGINATOR_NOTIFICATION in PhotoBrowserMediator");
					updateSparkView(note.getBody() as PaginatorData,photoBrowser.tileList);
					break;	
			}
		}//handleNotification end
	}
}