package com.captionmashup.modules.album.local.model
{
	import com.captionmashup.common.model.gateway.MainGateway;
	import com.captionmashup.common.model.local.paginator.PaginatorEvent;
	import com.captionmashup.common.model.proxy.PaginatorProxy.AbstractPaginatorProxy;
	import com.captionmashup.common.model.proxy.delegate.PhotoProxyDelegate;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	
	import mx.rpc.AsyncResponder;
	
	public class PhotoProxy extends AbstractPaginatorProxy
	{
		public static const NAME:String = "PhotoProxy";
		private var _responder:AsyncResponder;
		
		public function PhotoProxy()
		{
			super(NAME);
		}
		
		public function getAlbumPhotos(album_id:int,responder:AsyncResponder):void{
			//MainGateway.getAlbumService()
			var delegate:PhotoProxyDelegate = new PhotoProxyDelegate(responder);
			delegate.getAlbumPhotos(album_id);
		}
		
		override public function pageHandler(evt:PaginatorEvent):void{
			trace("pageHandler in PhotoProxy");
			sendNotification(ApplicationConstants.PHOTO_PAGINATOR_NOTIFICATION,evt.data);
		}
	}
}