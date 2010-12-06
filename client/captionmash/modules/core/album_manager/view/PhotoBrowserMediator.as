package com.captionmashup.modules.core.album_manager.view
{
	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.model.proxy.PaginatorProxy.IPaginatorProxy;
	import com.captionmashup.common.view.mediator.PaginatorMediator.AbstractPhotoBrowserMediator;
	import com.captionmashup.modules.core.album_manager.facade.ApplicationConstants;
	import com.captionmashup.modules.core.album_manager.model.PhotoProxy;
	import com.captionmashup.modules.core.album_manager.view.components.popup.photo.PhotoButtonCreatorPopup.PhotoButtonCreatorPopup;
	import com.captionmashup.modules.core.album_manager.view.components.popup.photo.PhotoManagerPopup.PhotoManagerActionTab;
	import com.captionmashup.modules.core.album_manager.view.components.popup.photo.PhotoManagerPopup.PhotoManagerPopup;
	import com.captionmashup.modules.core.album_manager.view.components.popup.photo.PhotoManagerPopup.PhotoManagerProperties;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	import spark.events.IndexChangeEvent;
	
	public class PhotoBrowserMediator extends AbstractPhotoBrowserMediator
	{
		public var photoManagerPopup:PhotoManagerPopup;
		public var photoButtonCreatorPopup:PhotoButtonCreatorPopup;
		
		public static const NAME:String = "PhotoBrowserMediator";
		public function PhotoBrowserMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
			
			photoBrowser.setSize(ApplicationConstants.PHOTO_THUMB_LIST_ROW_COUNT,
								ApplicationConstants.PHOTO_THUMB_LIST_COLUMN_COUNT);
			
			super.disableDefaultPopup();
			
			photoManagerPopup = new PhotoManagerPopup;
			
			photoManagerPopup.addEventListener(PhotoManagerPopup.CLOSE,onClose);
			photoManagerPopup.addEventListener(PhotoManagerActionTab.ADD_CAPTION,	onAddCaption);
			photoManagerPopup.addEventListener(PhotoManagerActionTab.ADD_TO_BASKET,	onAddToBasket);
			photoManagerPopup.addEventListener(PhotoManagerActionTab.CREATE_BUTTON,	onCreateButton);
			photoManagerPopup.addEventListener(PhotoManagerProperties.SAVE,	onSave);
			
			photoButtonCreatorPopup = new PhotoButtonCreatorPopup;
			
			photoButtonCreatorPopup.addEventListener(PhotoButtonCreatorPopup.CLOSE, 	  onPhotoButtonClose);
			photoButtonCreatorPopup.addEventListener(PhotoButtonCreatorPopup.IMAGE_CLICK, onImageClick);
		}
				
		override public function onRegister():void{
			paginatorProxy = facade.retrieveProxy(PhotoProxy.NAME) as IPaginatorProxy;
		}
		
		override protected function onIndexChange(evt:IndexChangeEvent):void{
			//fileReference.browse();	
			activePhoto = photoBrowser.tileList.selectedItem;
			sendNotification(ApplicationConstants.PHOTO_INDEX_CHANGED,photoBrowser.tileList.selectedItem);
		}
		
		override protected function sendMessageToShell(message:Message):void{
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,message);
		}

		/***********************************
		 * Event Listeners
		 * **********************************/
		
		override protected function onView(evt:Event):void{
			createPopup(photoManagerPopup,true);
			
			photoManagerPopup.imagePath 	= activePhoto.photo_path;
			photoManagerPopup.photoTitle	= activePhoto.title;
			photoManagerPopup.pageNo 	 	= activePhoto.page_no;
			photoManagerPopup.sourceUrl		= activePhoto.source_url;
			photoManagerPopup.fileSize		= activePhoto.file_size;
			photoManagerPopup.propertiesTab.saveButton.enabled = true;
		}
		
		private function onClose(evt:Event):void{
			photoManagerPopup.imagePath 	= null;
			photoManagerPopup.photoTitle	= null;
			photoManagerPopup.pageNo 	 	= 0;
			photoManagerPopup.sourceUrl		= null;
			photoManagerPopup.fileSize		= null;
			
			trace("AlbumManager PhotoBrowserMediator evt.currentTarget: "+evt.currentTarget);
			trace("AlbumManager PhotoBrowserMediator evt.target: "+evt.target);
			
			removePopup(photoManagerPopup);
			photoManagerPopup.propertiesTab.checkCross.visible = false;
			photoManagerPopup.propertiesTab.checkCross.valid = false;
		}
		
		//Action Tab Handlers
		private function onCreateButton(evt:Event):void{
			trace("Create Button event handled in PhotoBrowserMediator");
			createPopup(photoButtonCreatorPopup,true);
		}
		
		override protected function onAddCaption(evt:Event):void{
			removePopup(photoManagerPopup);
			sendNotification(ApplicationConstants.START_CREATE);
			
			super.onAddCaption(evt);
		}
		
		//Properties Tab handlers	
		private function onSave(evt:Event):void{
			photoManagerPopup.propertiesTab.saveButton.enabled = false;
			photoManagerPopup.propertiesTab.checkCross.visible = true;
			photoManagerPopup.propertiesTab.checkCross.animatePending();
			
			activePhoto.source_url 	= photoManagerPopup.sourceUrl;
			activePhoto.page_no	  	= photoManagerPopup.pageNo;
			activePhoto.title 		= photoManagerPopup.photoTitle;
			
			sendNotification(ApplicationConstants.SAVE_PHOTO,activePhoto);
		}
		
		//Button Popup handlers
		private function onPhotoButtonClose(evt:Event):void{
			removePopup(photoButtonCreatorPopup);
		}
		
		private function onImageClick(evt:Event):void{
			trace("Image clicked: "+evt.target);
			var imageLink:String 	= activePhoto.link; //http://localhost:8000/create/?p=sdfja
			var iconSource:String 	= photoButtonCreatorPopup.image_source;
			var targetURL:String 	= CommonConstants.HOMEPAGE;
			
			var html:String = '<a href="'+targetURL+'/create" ' +
								'onclick="window.open(\''+targetURL+'/create/?p='+activePhoto.link+'\'); return false"> ' +
								'<img src="'+iconSource+'"' +
								'alt="Caption this image!" border="0" /> </a>';
			
			photoButtonCreatorPopup.textArea.text = html;
		}
		
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.PHOTO_PAGINATOR_NOTIFICATION,
				ApplicationConstants.SAVE_PHOTO_SUCCESS,
				ApplicationConstants.SAVE_PHOTO_FAIL,
			];
		}

		override public function handleNotification(note:INotification):void
		{	
			switch (note.getName())
			{		
				case ApplicationConstants.PHOTO_PAGINATOR_NOTIFICATION:
					trace("Setting albums in UploadModule.AlbumBrowserMediator");
					updateSparkView(note.getBody() as PaginatorData,photoBrowser.tileList);
					break;
				
				case ApplicationConstants.SAVE_PHOTO_SUCCESS:
					photoManagerPopup.propertiesTab.checkCross.valid= true;
					break;
				
				case ApplicationConstants.SAVE_PHOTO_FAIL:
					photoManagerPopup.propertiesTab.checkCross.valid= false;
					break;
			}
		}//handleNotification end
	}
}