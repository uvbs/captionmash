package com.captionmashup.modules.album.local.view
{
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	import com.captionmashup.modules.album.local.view.components.Browser.Browser;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class BrowserMediator extends Mediator
	{
		public static const NAME:String = "BrowserMediator";
		
		public function BrowserMediator(viewComponent:Browser)
		{
			super(NAME, viewComponent);
			browser.currentState = Browser.GENRES_STATE;
			
			browser.addEventListener(Browser.BACK_TO_ALBUM,onBackToAlbum);
			browser.addEventListener(Browser.ADD_ALL_PHOTOS_TO_BASKET,onAddAllToBasket);
			browser.addEventListener(Browser.CAPTION_ALL_PHOTOS,onCaptionAllPhotos);
			
		}
		
		private function onBackToAlbum(evt:Event):void{
			browser.currentState = Browser.ALBUMS_STATE;
		}
		
		private function onAddAllToBasket(evt:Event):void{
			trace("BrowserMediator onAddAllToBasket called");
			sendNotification(ApplicationConstants.ADD_ALL_PHOTOS_TO_BASKET);
		}
		
		private function onCaptionAllPhotos(evt:Event):void{
			trace("BrowserMediator onCaptionAllPhotos called");	
			sendNotification(ApplicationConstants.CAPTION_ALL_PHOTOS);
		}
		
		public function get browser():Browser{
			return viewComponent as Browser;
		}
		
		override public function listNotificationInterests():Array
		{
			return [

			];
		}
		
		override public function handleNotification(note:INotification):void
		{	
			switch (note.getName())
			{

			}
		}//handleNotification end
	}
}