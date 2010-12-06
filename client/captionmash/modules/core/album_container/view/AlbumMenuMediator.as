package com.captionmashup.modules.core.album_container.view
{
	import com.captionmashup.common.pipe.message.album.LocalAlbumMessage;
	import com.captionmashup.common.pipe.message.core.BasketMessage;
	import com.captionmashup.common.pipe.message.core.NavigationMessage;
	import com.captionmashup.common.pipe.message.core.UploadMessage;
	import com.captionmashup.modules.core.album_container.facade.ApplicationConstants;
	import com.captionmashup.modules.core.album_container.view.components.AlbumMenu.AlbumMenu;
	import com.captionmashup.modules.core.album_container.view.components.AlbumMenu.AlbumSidebar;
	import com.captionmashup.modules.core.album_container.view.components.AlbumMenu.MenuHome;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	import spark.events.IndexChangeEvent;
	
	public class AlbumMenuMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'AlbumMenuMediator';
		
		public function AlbumMenuMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			albumMenu.currentState = "menu";
			//albumMenu.albumDropDownList.addEventListener(IndexChangeEvent.CHANGE,onDropDownIndexChange);
			
			albumMenu.addEventListener(MenuHome.FACEBOOK,onFacebook);
			albumMenu.addEventListener(MenuHome.LATEST_CAPTIONED_PHOTOS,onLatestCaptionedPhotos);
			albumMenu.addEventListener(MenuHome.LATEST_ADDED_PHOTOS,onLatestAddedPhotos);
			
			albumMenu.addEventListener(AlbumSidebar.GENRES,onGenres);
			albumMenu.addEventListener(AlbumSidebar.USERS,onUsers);
			albumMenu.addEventListener(AlbumSidebar.HOME,onHome);
			albumMenu.addEventListener(AlbumSidebar.BASKET,onBasket);
			albumMenu.addEventListener(AlbumSidebar.MANAGE_ALBUMS,onUpload);
		}
		public function get albumMenu():AlbumMenu{
			return viewComponent as AlbumMenu;
		}
		
		/*********************************
		 * Event Handlers
		 * *******************************/
		private function onHome(evt:Event):void{
			albumMenu.currentState = AlbumMenu.MENU_STATE;
			var navigationMessage:NavigationMessage = new NavigationMessage(NavigationMessage.ALBUM_HOME);
			sendMessageToShell(navigationMessage);
		}
		
		private function onBasket(evt:Event):void{
			var basketMessage:BasketMessage = new BasketMessage(BasketMessage.TOGGLE);
			sendMessageToShell(basketMessage);
		}
		
		private function onUsers(evt:Event):void{
			albumMenu.currentState = AlbumMenu.CAPTIONMASH_STATE;
			var localAlbumMessage:LocalAlbumMessage = new LocalAlbumMessage(LocalAlbumMessage.LIST_MEMBERS);
			sendMessageToShell(localAlbumMessage);
		}
		
		private function onGenres(evt:Event):void{
			albumMenu.currentState = AlbumMenu.CAPTIONMASH_STATE;
			var localAlbumMessage:LocalAlbumMessage = new LocalAlbumMessage(LocalAlbumMessage.LIST_GENRES);
			sendMessageToShell(localAlbumMessage);			
		}
		
		private function onUpload(evt:Event):void{
			var uploadMessage:UploadMessage = new UploadMessage(UploadMessage.SHOW);
			sendMessageToShell(uploadMessage);
		}
		
		private function onLatestCaptionedPhotos(evt:Event):void{
			sendNotification(ApplicationConstants.LIST_LATEST_CAPTIONED_PHOTOS);
		}
		
		private function onLatestAddedPhotos(evt:Event):void{
			sendNotification(ApplicationConstants.LIST_LATEST_ADDED_PHOTOS);
		}
		
		private function onFacebook(evt:Event):void{
			
			//Load facebook
			albumMenu.currentState = AlbumMenu.FACEBOOK_STATE;

			if( albumMenu.facebookContainer.numElements==0){
				trace("NO CHILDREN IN FACEBOOK PANEL");
				sendNotification(ApplicationConstants.GET_FACEOOK_UI);
			}
		}
		
		private function sendMessageToShell(message:Message):void{
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,message);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.BROWSE_IMAGES,
				ApplicationConstants.USER_LOGIN,
				ApplicationConstants.USER_LOGOUT,
			];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{	                	
				case ApplicationConstants.BROWSE_IMAGES:
					albumMenu.currentState = AlbumMenu.MENU_STATE;
					break;
				
				case ApplicationConstants.USER_LOGIN:
					albumMenu.albumSidebar.myAlbumsButton.enabled = true;
					break;
				
				case ApplicationConstants.USER_LOGOUT:
					albumMenu.albumSidebar.myAlbumsButton.enabled = false;
					break;
				

			}
		}
		
		
	}
}