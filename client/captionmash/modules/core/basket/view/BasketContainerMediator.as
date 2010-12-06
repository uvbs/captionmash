package com.captionmashup.modules.core.basket.view
{
	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.pipe.message.core.NavigationMessage;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.common.view.component.ThumbnailTileList.ThumbnailTileList;
	import com.captionmashup.modules.core.basket.facade.ApplicationConstants;
	import com.captionmashup.modules.core.basket.facade.ApplicationFacade;
	import com.captionmashup.modules.core.basket.view.components.BasketContainer.BasketContainer;
	import com.captionmashup.modules.core.basket.view.components.BasketContainer.EmptyScreen;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class BasketContainerMediator extends Mediator
	{
		public static const NAME:String = "BasketContainerMediator";
		
		public function BasketContainerMediator(basketContainer:BasketContainer)
		{
			trace("BasketContainer test: "+basketContainer);
			super(NAME, basketContainer);
			
			basketContainer.addEventListener(BasketContainer.CLOSE_BASKET,onClose);
			basketContainer.currentState = BasketContainer.EMPTY_STATE;
		}
		
		public function get photoBasket():ThumbnailTileList{
			return viewComponent.photoBasket as ThumbnailTileList;
		}
		
		public function get basketContainer():BasketContainer{
			return viewComponent as BasketContainer;
		}
		
		private function onClose(evt:Event):void{
			var popupMessage:PopupMessage = new PopupMessage(PopupMessage.REMOVE_POPUP,this.basketContainer);
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,popupMessage);
			ApplicationFacade.isDisplayed = false;
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
					var items:Array = PaginatorData(note.getBody()).items;
					if(items.length == 0){
						basketContainer.currentState = BasketContainer.EMPTY_STATE;
					}else{
						basketContainer.currentState = BasketContainer.NORMAL_STATE;
					}
					break;	
			}
		}//handleNotification end
		
	}
}