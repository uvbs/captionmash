package com.captionmashup.common.view.mediator.PaginatorMediator
{
	import com.captionmashup.common.model.local.dto.AlbumDTO;
	import com.captionmashup.common.pipe.message.core.BasketMessage;
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.common.view.component.ItemRenderer.AlbumRenderer.AlbumRenderer;
	import com.captionmashup.common.view.component.ItemRenderer.AlbumRenderer.AlbumRendererOverlay;
	import com.captionmashup.common.view.component.Popup.AlbumPopup.AlbumPopup;
	import com.captionmashup.common.view.component.SparkThumbnailTileList.SparkThumbnailTileList;
	
	import flash.events.Event;
	
	import mx.core.ClassFactory;
	
	import spark.events.IndexChangeEvent;

	public class AbstractAlbumBrowserMediator extends AbstractPaginatorMediator
	{
		private var albumPopup:AlbumPopup;
		private var activeAlbum:AlbumDTO;
		private var basketMessage:BasketMessage;
		private var creatorMessage:CreatorMessage;
		
		public function AbstractAlbumBrowserMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			
			albumPopup = new AlbumPopup;
			
			albumBrowser.tileList.initialize();
			
			albumBrowser.tileList.itemRenderer = new ClassFactory(AlbumRenderer);
			albumBrowser.tileList.addEventListener(IndexChangeEvent.CHANGE,onIndexChange);
			
			albumBrowser.addEventListener(AlbumRendererOverlay.ADD_TO_BASKET,onAddToBasket);
			albumBrowser.addEventListener(AlbumRendererOverlay.CAPTION_ALBUM, onStartCreate);
			albumBrowser.addEventListener(AlbumRendererOverlay.VIEW_ALBUM,onView);
		
		}
		
		public function get albumBrowser():SparkThumbnailTileList{
			return viewComponent as SparkThumbnailTileList;
		}
		
		protected function onIndexChange(evt:IndexChangeEvent):void{
			activeAlbum = albumBrowser.tileList.selectedItem;
		}
		
		protected function onStartCreate(evt:Event):void{
			trace("AbstractAlbumBrowserMediator.onStartCreate called");
			/*
			creatorMessage = new CreatorMessage(CreatorMessage.START_CREATE,
				activePhoto);
			sendMessageToShell(creatorMessage);
			*/
		}
		
		protected function onAddToBasket(evt:Event):void{
			trace("AbstractAlbumBrowserMediator.onAddtoBasket called");
			
			/*basketMessage = new BasketMessage(BasketMessage.ADD_PHOTO,null,
				activePhoto);
			sendMessageToShell(basketMessage);
			*/
		}
		
		protected function onView(evt:Event):void{
			trace("AbstractAlbumBrowserMediator.onView called");
			/*photoPopup.imagePath = activePhoto.photo_path;
			popupMessage = new PopupMessage(PopupMessage.CREATE_MODAL_POPUP,
				photoPopup);
			sendMessageToShell(popupMessage);
			*/
		}

	}
}