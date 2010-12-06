package com.captionmashup.modules.core.album_container.model
{
	import com.captionmashup.common.model.local.paginator.PaginatorEvent;
	import com.captionmashup.common.model.proxy.PaginatorProxy.AbstractPaginatorProxy;
	import com.captionmashup.common.model.proxy.delegate.PhotoProxyDelegate;
	import com.captionmashup.modules.core.album_container.facade.ApplicationConstants;
	
	import mx.rpc.AsyncResponder;
	
	public class PhotoProxy extends AbstractPaginatorProxy
	{
		public static const NAME:String = "PhotoProxy";
		
		public function PhotoProxy()
		{
			super(NAME);
		}
		
		override public function pageHandler(evt:PaginatorEvent):void{
			sendNotification(ApplicationConstants.PHOTO_PAGINATOR_NOTIFICATION,evt.data);
		}
		
		public function getLatestCaptionedPhotos(asyncResponder:AsyncResponder):void{
			var delegate:PhotoProxyDelegate = new PhotoProxyDelegate(asyncResponder);
			delegate.getLatestCaptionedPhotos();
		}
		
		public function getLatestAddedPhotos(asyncResponder:AsyncResponder):void{
			var delegate:PhotoProxyDelegate = new PhotoProxyDelegate(asyncResponder);
			delegate.getLatestAddedPhotos();
		}
	}
}