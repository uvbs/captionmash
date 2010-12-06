package com.captionmashup.modules.album.facebook.view
{
	import com.captionmashup.common.model.proxy.PaginatorProxy.IPaginatorProxy;
	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.common.view.component.ThumbnailTileList.ThumbnailTileList;
	import com.captionmashup.common.view.mediator.PaginatorMediator.AbstractPaginatorMediator;
	
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	
	import com.captionmashup.modules.album.facebook.model.dto.Album;
	import com.captionmashup.modules.album.facebook.model.proxy.AlbumProxy;
	
	import com.captionmashup.common.view.component.Popup.AlbumPopup.AlbumPopup;
	import com.captionmashup.modules.album.facebook.view.components.AlbumBrowser.itemrenderer.AlbumRenderer;
	
	import flash.events.Event;
	
	import mx.core.ClassFactory;
	import mx.events.ListEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class AlbumMediator extends AbstractPaginatorMediator
	{
		public static const NAME:String = "AlbumMediator";
		private var albumPopup:AlbumPopup;
		private var activeAlbum:Album;
		
		public function AlbumMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			albumPopup = new AlbumPopup();
			
			albums.setSize(ApplicationConstants.ALBUM_PAGE_ROW_SIZE,
							ApplicationConstants.ALBUM_PAGE_COLUMN_SIZE);
			
			albums.tileList.itemRenderer = new ClassFactory(AlbumRenderer);
			
			albums.tileList.addEventListener(ListEvent.ITEM_CLICK,onAlbumThumbClick);
			
			albumPopup.addEventListener(AlbumPopup.SELECT_ALBUM,onSelectAlbum);
			albumPopup.addEventListener(AlbumPopup.DESELECT,onDeselect);
		}
		
		public function get albums():ThumbnailTileList{
			return viewComponent as ThumbnailTileList;
		}
		
		override public function onRegister():void{
			paginatorProxy = facade.retrieveProxy(AlbumProxy.NAME) as IPaginatorProxy;
		}
		
		private function onAlbumThumbClick(evt:ListEvent):void{
			paginatorProxy.activeContent = evt.itemRenderer.data;
			activeAlbum = evt.itemRenderer.data as Album;
			albumPopup.imagePath = activeAlbum.cover_photo_path;
			trace("AlbumMediator.onAlbumThumbClick called: "+activeAlbum.cover_photo_path);
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,
								new PopupMessage(PopupMessage.CREATE_MODAL_POPUP,albumPopup));
		}
		
		/************************************
		 * Album Popup handlers
		 * Current bug: when clicked on button
		 * both handlers are executed
		 * *********************************/
		private function onSelectAlbum(evt:Event):void{
			trace("Album selected in AlbumMediator");
			sendNotification(ApplicationConstants.LOAD_PHOTOS,activeAlbum);
			
		}
		
		private function onDeselect(evt:Event):void{
			trace("Album deselected in AlbumMediator");
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,
				new PopupMessage(PopupMessage.REMOVE_POPUP,albumPopup));
		}
		
		/**********************************************
		 * NOTIFICATION HANDLERS
		 * ********************************************/
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
					updateView(note.getBody() as PaginatorData,albums.tileList);
					break;	
			}
		}//handleNotification end

	}
}