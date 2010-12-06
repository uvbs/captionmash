package com.captionmashup.modules.core.album_manager.controller.photo
{
	import com.captionmashup.common.model.local.dto.AlbumDTO;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.album_manager.facade.ApplicationConstants;
	import com.captionmashup.modules.core.album_manager.model.UserProxy;
	import com.captionmashup.modules.core.album_manager.view.AlbumBrowserMediator;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/*****************************
	 * Called when user selects an
	 * album in AlbumBrowser
	 * 
	 * notification body: FileReference
	 * 
	 * TODO ADD UPLOAD PROGRESS SPINNER/PROGRESSBAR
	 * ***************************/
	public class UploadPhotoCommand extends SimpleCommand
	{
		private var fileReference:FileReference;
		private var albumBrowserMediator:AlbumBrowserMediator;
		private var userProxy:UserProxy;
		private var selectedAlbum:AlbumDTO;
		
		override public function execute(notification:INotification):void
		{
			trace("UploadFileCommand called");
			albumBrowserMediator = facade.retrieveMediator(AlbumBrowserMediator.NAME) as AlbumBrowserMediator;
			userProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			
			t.obj(albumBrowserMediator.albumBrowser.tileList.selectedItem,"selected album");
			selectedAlbum = AlbumDTO(albumBrowserMediator.albumBrowser.tileList.selectedItem);
			var user_id:int = userProxy.user.django_id;
			
			
			fileReference = notification.getBody() as FileReference;	
			trace("File name: "+fileReference.name);
			
			if(fileReference.size >  ApplicationConstants.IMAGE_SIZE_LIMIT){
				sendNotification(ApplicationConstants.UPLOAD_SIZE_ERROR);
				return;
			}
			
			
			sendNotification(ApplicationConstants.UPLOAD_STARTED);
			upload(fileReference,selectedAlbum.django_id,user_id);
		}
		
		//File upload can't be authenticated (FLASH DOES NOT ALLOW SESSION CONTROL FOR UPLOAD)
		//So we use user_id from UserProxy
		private function upload(fileReference:FileReference,album_id:int,user_id:int):void{
			try {
				//500 kb image size
				if(fileReference.size > ApplicationConstants.IMAGE_SIZE_LIMIT){
					trace("BIG FILE LOL"+fileReference.size);
					return;
				}
				
				fileReference.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,onUploadComplete);
				fileReference.addEventListener(Event.COMPLETE,onComplete);
				
				var data:URLVariables = new URLVariables();
				data.user_id = user_id;
				data.album_id = album_id;
				//message.text = "size (bytes): " + numberFormatter.format(fileRef.size);
				var request:URLRequest = new URLRequest(ApplicationConstants.DJANGO_UPLOAD_URL);
				request.method = URLRequestMethod.POST;
				request.data = data;
				
				trace("Album id : "+album_id);
				trace("User id : "+user_id);
				t.obj(request,"Request");
				fileReference.upload(request,"file");
			} catch (err:Error) {
				//message.text = "ERROR: zero-byte file";
			}
		}
		
		private function onUploadComplete(evt:DataEvent):void{
			t.obj(evt.data,"evt.data in UploadFileCommand.onUploadComplete");
			fileReference.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA,onUploadComplete);
		}
		
		private function onComplete(evt:Event):void{
			t.obj(evt,"evt in UploadFileCommand.onComplete");
			fileReference.removeEventListener(Event.COMPLETE,onComplete);
			sendNotification(ApplicationConstants.GET_ALBUM_PHOTOS,selectedAlbum);
			sendNotification(ApplicationConstants.GET_USER_ALBUMS);
			sendNotification(ApplicationConstants.UPLOAD_FINISHED);
		}
	}
}