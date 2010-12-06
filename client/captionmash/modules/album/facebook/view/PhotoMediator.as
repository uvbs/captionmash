package com.captionmashup.modules.album.facebook.view
{
	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.model.proxy.PaginatorProxy.IPaginatorProxy;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.common.view.component.ThumbnailTileList.ThumbnailTileList;
	import com.captionmashup.common.view.mediator.PaginatorMediator.AbstractPaginatorMediator;
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.modules.album.facebook.model.dto.Photo;
	import com.captionmashup.modules.album.facebook.model.proxy.PhotoProxy;
	import com.captionmashup.common.view.component.Popup.PhotoPopup.PhotoPopup;
	import com.captionmashup.modules.album.facebook.view.components.AlbumBrowser.itemrenderer.PhotoRenderer;
	
	import flash.events.Event;
	
	import mx.core.ClassFactory;
	import mx.events.ListEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class PhotoMediator extends AbstractPaginatorMediator
	{
		public static const NAME:String = "PhotoMediator";
		private var activePhoto:Photo;
		private var photoPopup:PhotoPopup;
		
		public function PhotoMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			photoPopup = new PhotoPopup;
			
			photos.setSize(ApplicationConstants.PHOTO_PAGE_ROW_SIZE,
				ApplicationConstants.PHOTO_PAGE_COLUMN_SIZE);
			
			photos.tileList.itemRenderer = new ClassFactory(PhotoRenderer);
			
			photos.tileList.addEventListener(ListEvent.ITEM_CLICK,onPhotoThumbClick);
			
			photoPopup.addEventListener(PhotoPopup.SELECT_PHOTO,onSelectPhoto);
			photoPopup.addEventListener(PhotoPopup.ADD_TO_BASKET,onAddToBasket);
			photoPopup.addEventListener(PhotoPopup.DESELECT,onDeselect);
		}
		
		public function get photos():ThumbnailTileList{
			return viewComponent as ThumbnailTileList;
		}
		
		override public function onRegister():void{
			paginatorProxy = facade.retrieveProxy(PhotoProxy.NAME) as IPaginatorProxy;
		}
		
		private function onPhotoThumbClick(evt:ListEvent):void{
			paginatorProxy.activeContent = evt.itemRenderer.data;
			activePhoto = evt.itemRenderer.data as Photo;
			photoPopup.imagePath = activePhoto.photo_path;
			trace("PhotoMediator.onPhotoThumbClick called: "+activePhoto.photo_path);
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,
				new PopupMessage(PopupMessage.CREATE_MODAL_POPUP,photoPopup));
		}
		
		/************************************
		 * Photo Popup handlers
		 * Current bug: when clicked on button
		 * both handlers are executed
		 * *********************************/
		private function onSelectPhoto(evt:Event):void{
			trace("Photo selected in PhotoMediator");
			sendNotification(ApplicationConstants.START_CREATE);
			//sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,
			//	new PopupMessage(PopupMessage.CREATE_MODAL_POPUP,photoPopup));	
			//sendNotification(ApplicationConstants.LOAD_PHOTOS,activePhoto);
		}
		
		private function onAddToBasket(ev:Event):void{
			sendNotification(ApplicationConstants.ADD_TO_BASKET);
		}
		
		private function onDeselect(evt:Event):void{
			trace("Photo deselected in PhotoMediator");
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,
				new PopupMessage(PopupMessage.REMOVE_POPUP,photoPopup));
		}
		
		/**********************************************
		 * NOTIFICATION HANDLERS
		 * ********************************************/
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
					
					updateView(note.getBody() as PaginatorData,photos.tileList);
					break;	
			}
		}//handleNotification end
	}
}