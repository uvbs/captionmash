package com.captionmashup.modules.core.album_manager.view
{

	import com.captionmashup.common.model.local.dto.AlbumDTO;
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.modules.core.album_manager.facade.ApplicationConstants;
	import com.captionmashup.modules.core.album_manager.view.components.AlbumManager.AlbumControlSideBar;
	import com.captionmashup.modules.core.album_manager.view.components.AlbumManager.AlbumManagerPopup;
	import com.captionmashup.modules.core.album_manager.view.components.popup.album.AlbumDeletePopup.AlbumDeletePopup;
	import com.captionmashup.modules.core.album_manager.view.components.popup.album.CreateAlbumPopup.CreateAlbumPopup;
	import com.captionmashup.modules.core.album_manager.view.components.popup.photo.PhotoDeletePopup.PhotoDeletePopup;
	import com.captionmashup.modules.core.album_manager.view.components.popup.UploadProgressPopup.UploadProgressPopup;
	
	import flash.events.Event;
	import flash.net.FileReference;
	
	import mx.events.CloseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class AlbumManagerMediator extends Mediator
	{
		public static const NAME:String = "AlbumManagerMediator";
		private var uploadProgressPopup:UploadProgressPopup;
		private var createAlbumPopup:CreateAlbumPopup;
		private var albumDeletePopup:AlbumDeletePopup;
		private var photoDeletePopup:PhotoDeletePopup;
		private var popupMessage:PopupMessage;

		private var fileReference:FileReference;
		
		private var photo_flag:Boolean = false;
		private var album_flag:Boolean = false;
		
		public function AlbumManagerMediator(viewComponent:AlbumManagerPopup)
		{
			super(NAME, viewComponent);
			
			uploadProgressPopup = new UploadProgressPopup;
			
			uploadPopup.addEventListener(CloseEvent.CLOSE,onClose);
			
			uploadPopup.addEventListener(AlbumControlSideBar.CREATE_ALBUM,onCreateAlbum);
			uploadPopup.addEventListener(AlbumControlSideBar.UPLOAD_PHOTO,onUpload);
			uploadPopup.addEventListener(AlbumControlSideBar.DELETE_PHOTO,onPhotoDelete);
			uploadPopup.addEventListener(AlbumControlSideBar.DELETE_ALBUM,onAlbumDelete);
			
			createAlbumPopup = new CreateAlbumPopup;
			createAlbumPopup.addEventListener(CloseEvent.CLOSE,onCreateAlbumPopupClose);
			createAlbumPopup.addEventListener(CreateAlbumPopup.SUBMIT_ALBUM_NAME,onCreateAlbumPopupSubmit);
			createAlbumPopup.addEventListener(CreateAlbumPopup.CANCEL_ALBUM_CREATE,onCreateAlbumPopupClose);
			
			albumDeletePopup = new AlbumDeletePopup;
			albumDeletePopup.initialize();
			albumDeletePopup.addEventListener(AlbumDeletePopup.CONFIRM_ALBUM_DELETE,onAlbumDeleteConfirm);
			albumDeletePopup.addEventListener(AlbumDeletePopup.CANCEL_ALBUM_DELETE,onAlbumDeleteCancel);
			
			photoDeletePopup = new PhotoDeletePopup;
			photoDeletePopup.initialize();
			photoDeletePopup.addEventListener(PhotoDeletePopup.CONFIRM_PHOTO_DELETE,onPhotoDeleteConfirm);
			photoDeletePopup.addEventListener(PhotoDeletePopup.CANCEL_PHOTO_DELETE,onPhotoDeleteCancel);
				
			fileReference = new FileReference;
			fileReference.addEventListener(Event.SELECT,onSelect);
		}
		
		public function get uploadPopup():AlbumManagerPopup{
			return viewComponent as AlbumManagerPopup;
		}
		
		/*************************************
		 * Album & Photo selection updaters
		 * ***********************************/
		public function set album_selected_flag(value:Boolean):void{
			album_flag = value;
			updateAlbumControlSideBar();
		}
		
		public function set photo_selected_flag(value:Boolean):void{
			photo_flag = value;
			updateAlbumControlSideBar();
		}
		
	
		/****************************
		 * Event Handlers
		 * **************************/
		private function onClose(evt:CloseEvent):void{
			album_selected_flag = false;
			photo_selected_flag = false;
			sendNotification(ApplicationConstants.CLOSE_MANAGER);
			removePopup(uploadPopup);
		}
		
		private function onUpload(evt:Event):void{
			trace("UploadPopupMediator onSelect called");
			fileReference.browse();
		}
		//Album selected, start upload
		private function onSelect(evt:Event):void{
			trace("UploadPopupMediator onSelect called");
			sendNotification(ApplicationConstants.UPLOAD_TO_ALBUM,fileReference);
		}
		
		//Album Creation
		private function onCreateAlbum(evt:Event):void{
			createPopup(createAlbumPopup);
		}
		
		private function onCreateAlbumPopupSubmit(evt:Event):void{
			trace("Submit album create in UploadPopupMediator");
			sendNotification(ApplicationConstants.CREATE_ALBUM,createAlbumPopup.albumNameInput.text);
			removePopup(createAlbumPopup);
		}
		
		private function onCreateAlbumPopupClose(evt:Event):void{
			removePopup(createAlbumPopup);
		}
		
		//Album Deletion
		private function onAlbumDelete(evt:Event):void{
			createPopup(albumDeletePopup);
		}
		
		private function onAlbumDeleteConfirm(evt:Event):void{
			trace("Album delete confirm");
			sendNotification(ApplicationConstants.DELETE_ALBUM);
			removePopup(albumDeletePopup);
		}
		
		private function onAlbumDeleteCancel(evt:Event):void{
			trace("Album delete cancel");
			removePopup(albumDeletePopup);
		}
		
		
		//Photo Deletion
		private function onPhotoDelete(evt:Event):void{
			createPopup(photoDeletePopup);
		}
		
		private function onPhotoDeleteConfirm(evt:Event):void{
			trace("Photo delete confirm");
			sendNotification(ApplicationConstants.DELETE_PHOTO);
			removePopup(photoDeletePopup);
		}
		
		private function onPhotoDeleteCancel(evt:Event):void{
			trace("Photo delete cancel");	
			removePopup(photoDeletePopup);
		}
		
		private function createPopup(obj:Object):void{
			popupMessage = new PopupMessage(PopupMessage.CREATE_MODAL_POPUP,obj);
			sendMessageToShell(popupMessage);
		}
		
		private function removePopup(obj:Object):void{
			popupMessage = new PopupMessage(PopupMessage.REMOVE_POPUP,obj);
			sendMessageToShell(popupMessage);			
		}
		
		private function sendMessageToShell(message:Message):void{
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,popupMessage);
		}
		
		private function updateAlbumControlSideBar():void{
			if(photo_flag && album_flag){
				uploadPopup.albumControlSideBar.currentState = AlbumControlSideBar.BOTH_SELECTED_STATE;
			}else if (photo_flag && !album_flag){
				uploadPopup.albumControlSideBar.currentState = AlbumControlSideBar.PHOTO_SELECTED_STATE;
			}else if (!photo_flag && album_flag){
				uploadPopup.albumControlSideBar.currentState = AlbumControlSideBar.ALBUM_SELECTED_STATE;
			}else if (!photo_flag && !album_flag){
				uploadPopup.albumControlSideBar.currentState = AlbumControlSideBar.NO_SELECT_STATE;
			}
		}
		
		/**********************************************
		 * NOTIFICATION HANDLERS
		 * ********************************************/
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.START_CREATE,
				ApplicationConstants.ALBUM_INDEX_CHANGED,
				ApplicationConstants.PHOTO_INDEX_CHANGED,
				ApplicationConstants.UPLOAD_STARTED,
				ApplicationConstants.UPLOAD_FINISHED,
				ApplicationConstants.UPLOAD_FAILED,
				ApplicationConstants.ALBUM_PAGINATOR_NOTIFICATION,
				ApplicationConstants.PHOTO_PAGINATOR_NOTIFICATION,
				,	
			];
		}
		
		override public function handleNotification(note:INotification):void
		{
			
			switch (note.getName())
			{	
				case ApplicationConstants.ALBUM_INDEX_CHANGED:
					var albumDTO:AlbumDTO = note.getBody() as AlbumDTO;

					album_selected_flag = true;
					albumDeletePopup.imageContainer.imagePath = albumDTO.photo_path;
					albumDeletePopup.albumName.text = albumDTO.name;
					photoDeletePopup.imageContainer.imagePath = null;
					
					break;
				
				case ApplicationConstants.PHOTO_INDEX_CHANGED:
					photo_selected_flag = true;
					var photoDTO:PhotoDTO = note.getBody() as PhotoDTO;
					photoDeletePopup.imageContainer.imagePath = photoDTO.photo_path;
					break;
				
				case ApplicationConstants.UPLOAD_STARTED:
					album_selected_flag = false;
					photo_selected_flag = false;
					createPopup(uploadProgressPopup);
					break;
				
				case ApplicationConstants.UPLOAD_FINISHED:
				case ApplicationConstants.UPLOAD_FAILED:
					removePopup(uploadProgressPopup);
					break;
				
				case ApplicationConstants.ALBUM_PAGINATOR_NOTIFICATION:
					album_selected_flag = false;
					break;
				
				case ApplicationConstants.PHOTO_PAGINATOR_NOTIFICATION:
					photo_selected_flag = false;
					break;
				
				case ApplicationConstants.START_CREATE:
					removePopup(uploadPopup);
					break;
				
				
			}
		}//handleNotification end
	}
	
}