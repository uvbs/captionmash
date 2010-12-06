package com.captionmashup.modules.core.basket.view
{
	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.model.proxy.PaginatorProxy.IPaginatorProxy;
	import com.captionmashup.common.view.component.SparkThumbnailTileList.SparkThumbnailTileList;
	import com.captionmashup.common.view.mediator.PaginatorMediator.AbstractPaginatorMediator;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.basket.facade.ApplicationConstants;
	import com.captionmashup.modules.core.basket.model.PhotoBasketProxy;
	import com.captionmashup.modules.core.basket.view.components.BasketContainer.ItemRenderer.PhotoRenderer;
	import com.captionmashup.modules.core.basket.view.components.BasketContainer.ItemRenderer.PhotoRendererOverlay;
	
	import flash.events.Event;
	
	import mx.core.ClassFactory;
	import mx.events.DragEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
		
	public class PhotoBasketMediator extends AbstractPaginatorMediator
	{
		public static const NAME:String = "PhotoBasketMediator";
		
		public function PhotoBasketMediator(viewComponent:SparkThumbnailTileList)
		{
			trace("photoBasket super init: "+photoBasket);
			super(NAME, viewComponent);
			
			photoBasket.tileList.dragEnabled = true;
			photoBasket.tileList.itemRenderer = new ClassFactory(PhotoRenderer);
			photoBasket.setSize(ApplicationConstants.PHOTO_BASKET_ROW_COUNT,
								ApplicationConstants.PHOTO_BASKET_COLUMN_COUNT);
			
			photoBasket.tileList.addEventListener(PhotoRendererOverlay.REMOVE_PHOTO,onRemovePhoto);
			
			photoBasket.tileList.addEventListener(DragEvent.DRAG_START,onDragStart);
		}
		
		public function get photoBasket():SparkThumbnailTileList{
			return viewComponent as SparkThumbnailTileList;
		}
		
		override public function onRegister():void{
			paginatorProxy = facade.retrieveProxy(PhotoBasketProxy.NAME) as IPaginatorProxy;
		}
		
		/****************************
		 * Event Handlers
		 * **************************/
		private function onRemovePhoto(evt:Event):void{
			trace("onRemovePhotoCalled");
			paginatorProxy.removeElementAt(photoBasket.tileList.selectedIndex);
		}
		
		private function onDragStart(evt:DragEvent):void{
			trace("drag started");
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
					
					updateSparkView(note.getBody() as PaginatorData,photoBasket.tileList);
					t.obj(note.getBody(),"PhotoBasketMediator note.getBody()");
					break;	
			}
		}//handleNotification end
	}
	
}