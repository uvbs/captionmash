package com.captionmashup.modules.core.album_manager.model
{
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	import com.captionmashup.common.model.local.paginator.PaginatorEvent;
	import com.captionmashup.common.model.proxy.PaginatorProxy.AbstractPaginatorProxy;
	import com.captionmashup.common.model.proxy.delegate.PhotoProxyDelegate;
	import com.captionmashup.modules.core.album_manager.facade.ApplicationConstants;
	
	import mx.rpc.AsyncResponder;
	
	public class PhotoProxy extends AbstractPaginatorProxy
	{
		public static const NAME:String 	= "PhotoProxy";
		public function PhotoProxy()
		{
			super(NAME);
		}
		
		override public function pageHandler(evt:PaginatorEvent):void{
			trace("pageHandler in UploadModule.PhotoProxy");
			sendNotification(ApplicationConstants.PHOTO_PAGINATOR_NOTIFICATION,evt.data);
		}
		
		public function getAlbumPhotos(album_id:int,asyncResponder:AsyncResponder):void{
			var delegate:PhotoProxyDelegate = new PhotoProxyDelegate(asyncResponder);
			delegate.getAlbumPhotos(album_id);
		}
		
		public function deletePhoto(photo_id:int,asyncResponder:AsyncResponder):void{
			var delegate:PhotoProxyDelegate = new PhotoProxyDelegate(asyncResponder);
			delegate.deletePhoto(photo_id);
		}
		
		public function savePhoto(photoDTO:PhotoDTO,asyncResponder:AsyncResponder):void{
			var delegate:PhotoProxyDelegate = new PhotoProxyDelegate(asyncResponder);
			delegate.savePhoto(photoDTO);
		}
	}
}