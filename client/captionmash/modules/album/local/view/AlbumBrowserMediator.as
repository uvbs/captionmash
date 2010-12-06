package com.captionmashup.modules.album.local.view
{
	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.model.proxy.PaginatorProxy.IPaginatorProxy;
	import com.captionmashup.common.view.component.SparkThumbnailTileList.SparkThumbnailTileList;
	import com.captionmashup.common.view.mediator.PaginatorMediator.AbstractAlbumBrowserMediator;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	import com.captionmashup.modules.album.local.model.AlbumProxy;
	import com.captionmashup.modules.album.local.view.components.Browser.ItemRenderer.AlbumRenderer;
	
	import mx.core.ClassFactory;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	import spark.events.IndexChangeEvent;
	
	public class AlbumBrowserMediator extends AbstractAlbumBrowserMediator
	{
		
		public static const NAME:String = "AlbumBrowserMediator";
		
		public function AlbumBrowserMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);

			albumBrowser.setSize(ApplicationConstants.ALBUM_LIST_ROW_COUNT,
									ApplicationConstants.ALBUM_LIST_COLUMN_COUNT);

		}
		
		override public function onRegister():void{
			paginatorProxy = facade.retrieveProxy(AlbumProxy.NAME) as IPaginatorProxy;
		}

		override protected function sendMessageToShell(message:Message):void{
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,message);
		}
		
		
		override protected function onIndexChange(evt:IndexChangeEvent):void{
			sendNotification(ApplicationConstants.LIST_PHOTOS,albumBrowser.tileList.selectedItem);
			albumBrowser.tileList.selectedIndex = -1;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.ALBUM_PAGINATOR_NOTIFICATION,
			];
		}
		
		override public function handleNotification(note:INotification):void
		{	
			switch (note.getName())
			{
				case ApplicationConstants.ALBUM_PAGINATOR_NOTIFICATION:
					trace("Handling ALBUM_PAGINATOR_NOTIFICATION in AlbumBrowserMediatorrrrr");
					updateSparkView(note.getBody() as PaginatorData,albumBrowser.tileList);
					break;	
			}
		}//handleNotification end
	}
}