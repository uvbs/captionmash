package com.captionmashup.modules.core.album_manager.controller.photo
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.model.local.dto.AlbumDTO;
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	import com.captionmashup.modules.core.album_manager.facade.ApplicationConstants;
	import com.captionmashup.modules.core.album_manager.model.PhotoProxy;
	import com.captionmashup.modules.core.album_manager.view.PhotoBrowserMediator;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class DeletePhotoCommand extends AbstractRPCCommand
	{
		private var photoProxy:PhotoProxy;
		private var photoBrowserMediator:PhotoBrowserMediator;
		
		override public function execute(notification:INotification):void{
			photoProxy = facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;
			photoBrowserMediator = facade.retrieveMediator(PhotoBrowserMediator.NAME) as PhotoBrowserMediator;
			
			var photo_id:int = PhotoDTO(photoBrowserMediator.photoBrowser.tileList.selectedItem).django_id;
			
			photoProxy.deletePhoto(photo_id,asyncResponder);
		}
		
		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			photoProxy.setPaginator(evt.result as Array,ApplicationConstants.PHOTO_PAGINATOR_PAGE_SIZE);
			sendNotification(ApplicationConstants.GET_USER_ALBUMS);
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
			trace("Fault at UploadModule.DeletePhotoCommand");	
		}
	}
}