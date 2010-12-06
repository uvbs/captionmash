package com.captionmashup.modules.core.album_manager.view
{
	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.model.proxy.PaginatorProxy.IPaginatorProxy;
	import com.captionmashup.common.view.component.SparkThumbnailTileList.SparkThumbnailTileList;
	import com.captionmashup.common.view.mediator.PaginatorMediator.AbstractPaginatorMediator;
	import com.captionmashup.modules.core.album_manager.facade.ApplicationConstants;
	import com.captionmashup.modules.core.album_manager.model.AlbumProxy;
	import com.captionmashup.modules.core.album_manager.view.components.AlbumManager.ItemRenderer.AlbumRenderer;
	import com.captionmashup.modules.core.album_manager.view.components.popup.error.FileSizeErrorPopup.FileSizeErrorPopup;
	
	import flash.events.Event;
	
	import mx.core.ClassFactory;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	import spark.events.IndexChangeEvent;
	
	public class AlbumBrowserMediator extends AbstractPaginatorMediator
	{
		public static const NAME:String = "AlbumBrowserMediator"
			
	 	private var fileSizeErrorPopup:FileSizeErrorPopup;
		
		public function AlbumBrowserMediator(viewComponent:SparkThumbnailTileList)
		{
			super(NAME, viewComponent);
			albumBrowser.setSize(ApplicationConstants.ALBUM_THUMB_LIST_ROW_COUNT,
									ApplicationConstants.ALBUM_THUMB_LIST_COLUMN_COUNT);
			albumBrowser.tileList.itemRenderer = new ClassFactory(AlbumRenderer);
			albumBrowser.tileList.addEventListener(IndexChangeEvent.CHANGE,onIndexChange);
			
			fileSizeErrorPopup = new FileSizeErrorPopup();
			
			fileSizeErrorPopup.addEventListener(FileSizeErrorPopup.CLOSE,onFileSizeErrorClose);
		}
		
		public function get albumBrowser():SparkThumbnailTileList{
			return viewComponent as SparkThumbnailTileList;
		}
		
		override public function onRegister():void{
			paginatorProxy = facade.retrieveProxy(AlbumProxy.NAME) as IPaginatorProxy;
		}
		
		override protected function sendMessageToShell(message:Message):void{
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,message);
		}
		
		private function onIndexChange(evt:IndexChangeEvent):void{
			//fileReference.browse();	
			sendNotification(ApplicationConstants.GET_ALBUM_PHOTOS,albumBrowser.tileList.selectedItem);
			sendNotification(ApplicationConstants.ALBUM_INDEX_CHANGED,albumBrowser.tileList.selectedItem);
		}
		
		private function onFileSizeErrorClose(evt:Event):void{
			removePopup(fileSizeErrorPopup);
		}
		
		

		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.ALBUM_PAGINATOR_NOTIFICATION,
				ApplicationConstants.UPLOAD_SIZE_ERROR,
			];
		}
	
		override public function handleNotification(note:INotification):void
		{	
			switch (note.getName())
			{		
				case ApplicationConstants.ALBUM_PAGINATOR_NOTIFICATION:
					trace("Setting albums in UploadModule.AlbumBrowserMediator");
					updateSparkView(note.getBody() as PaginatorData,albumBrowser.tileList);
					break;	
				
				case ApplicationConstants.UPLOAD_SIZE_ERROR:
					createPopup(fileSizeErrorPopup,true);
					break;
			}
		}//handleNotification end
		
	}
}