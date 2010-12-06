package com.captionmashup.common.view.mediator.PaginatorMediator
{
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	import com.captionmashup.common.pipe.message.core.BasketMessage;
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.common.view.component.ItemRenderer.PhotoRenderer.PhotoRenderer;
	import com.captionmashup.common.view.component.ItemRenderer.PhotoRenderer.PhotoRendererOverlay;
	import com.captionmashup.common.view.component.Popup.PhotoPopup.PhotoPopup;
	import com.captionmashup.common.view.component.SparkThumbnailTileList.SparkThumbnailTileList;
	
	import flash.events.Event;
	
	import mx.core.ClassFactory;
	
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	import spark.events.IndexChangeEvent;

	public class AbstractPhotoBrowserMediator extends AbstractPaginatorMediator
	{
		protected var photoPopup:PhotoPopup;
		
		protected var activePhoto:PhotoDTO;
		protected var creatorMessage:CreatorMessage;
		protected var basketMessage:BasketMessage;
		
		public function AbstractPhotoBrowserMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			photoPopup = new PhotoPopup;
			
			photoBrowser.tileList.initialize();
			
			photoBrowser.tileList.itemRenderer = new ClassFactory(PhotoRenderer);
			photoBrowser.tileList.addEventListener(IndexChangeEvent.CHANGE,onIndexChange);
			
			photoBrowser.addEventListener(PhotoRendererOverlay.ADD_TO_BASKET,onAddToBasket);
			photoBrowser.addEventListener(PhotoRendererOverlay.CAPTION_PHOTO,onAddCaption);
			photoBrowser.addEventListener(PhotoRendererOverlay.VIEW_PHOTO,onView);
			
			photoPopup.addEventListener(PhotoPopup.SELECT_PHOTO,	onAddCaption);
			photoPopup.addEventListener(PhotoPopup.ADD_TO_BASKET,	onAddToBasket);
			photoPopup.addEventListener(PhotoPopup.DESELECT,		onDeselect);
		}
		
		public function disableDefaultPopup():void{			
			photoPopup.removeEventListener(PhotoPopup.SELECT_PHOTO,	onAddCaption);
			photoPopup.removeEventListener(PhotoPopup.ADD_TO_BASKET,onAddToBasket);
			photoPopup.removeEventListener(PhotoPopup.DESELECT,		onDeselect);
			
			photoPopup = null;
		}
		
		public function get photoBrowser():SparkThumbnailTileList{
			return viewComponent as SparkThumbnailTileList;
		}
		
		protected function onIndexChange(evt:IndexChangeEvent):void{
			activePhoto = photoBrowser.tileList.selectedItem;
		}
		
		protected function onAddCaption(evt:Event):void{
			creatorMessage = new CreatorMessage(CreatorMessage.START_CREATE,
				activePhoto);
			sendMessageToShell(creatorMessage);
		}
		
		protected function onAddToBasket(evt:Event):void{
			basketMessage = new BasketMessage(BasketMessage.ADD_PHOTO,activePhoto);
			sendMessageToShell(basketMessage);
		}
		
		protected function onView(evt:Event):void{
			if(photoPopup == null) return;
			trace("onView in AbstractPhotoBrowserMediator");
			photoPopup.imagePath = activePhoto.photo_path;
			createPopup(photoPopup,true);
		}
		
		protected function onDeselect(evt:Event):void{
			activePhoto = null;
			photoPopup.imagePath = null;
			photoBrowser.tileList.selectedIndex = -1;
			popupMessage = new PopupMessage(PopupMessage.REMOVE_POPUP,photoPopup);
			sendMessageToShell(popupMessage);
		}
	}
}