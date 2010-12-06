package com.captionmashup.modules.album.facebook.model.proxy
{
	import com.captionmashup.common.model.foreign.IAlbum;
	import com.captionmashup.common.model.local.paginator.PaginatorEvent;
	import com.captionmashup.common.model.proxy.PaginatorProxy.AbstractPaginatorProxy;
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.modules.album.facebook.model.dto.Photo;
	import com.captionmashup.common.model.gateway.FacebookGraphGateway;
	import com.captionmashup.modules.album.facebook.fql.FqlCreateUtil;
	
	public class PhotoProxy extends AbstractPaginatorProxy
	{
		public static const NAME:String = "PhotoProxy";
		
		public function PhotoProxy()
		{
			super(NAME);
		}
		
		public function loadPhotos(album:IAlbum,callback:Function):void{
			var queryObject:Object = new Object();
			queryObject = FqlCreateUtil.createAlbumPhotosFQL(album.albumId);
			FacebookGraphGateway.callFQL(queryObject.query,callback);
		}
		
		//This function is added as listener in AbstractPaginatorProxy
		override public function pageHandler(evt:PaginatorEvent):void
		{
			sendNotification(ApplicationConstants.PHOTO_PAGINATOR_NOTIFICATION,evt.data);
		}
	}
}