package com.captionmashup.modules.core.caption_browser.model
{
	import com.captionmashup.common.model.local.paginator.PaginatorEvent;
	import com.captionmashup.common.model.proxy.PaginatorProxy.AbstractPaginatorProxy;
	import com.captionmashup.common.model.proxy.delegate.CaptionProxyDelegate;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.caption_browser.facade.ApplicationConstants;
	
	import flash.events.Event;
	
	import mx.rpc.AsyncResponder;
	
	public class CaptionProxy extends AbstractPaginatorProxy
	{
		public static const GET_CAPTIONS_BY_PHOTO_ID:String = "get_captions_by_photo_id";
		public static const GET_CAPTION_BY_ID:String = "get_caption_by_id";
		//public static const POST_CAPTION:String = "post_caption";
		
		public static const NAME:String = 'CaptionProxy';
		
		private var lastCallPhotoID:int;
		
		public function CaptionProxy(proxyName:String=null)
		{
			super(NAME);
			lastCallPhotoID = 0;
			
		}
		
		public function getLatestCaptions(responder:AsyncResponder):void{
			var delegate:CaptionProxyDelegate = new CaptionProxyDelegate(responder);
			delegate.getLatestCaptions();
		}
		
		
		//paginator notification handlers
		override public function pageHandler(evt:PaginatorEvent):void{
			trace("pageHandler of captionProxy called!");
			sendNotification(ApplicationConstants.CAPTION_PAGINATOR_NOTIFICATION,evt.data);
		}
	}
}