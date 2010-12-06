package com.captionmashup.modules.core.basket.model
{
	import com.captionmashup.common.model.local.paginator.PaginatorEvent;
	import com.captionmashup.common.model.proxy.PaginatorProxy.AbstractPaginatorProxy;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.basket.facade.ApplicationConstants;
	
	public class PhotoBasketProxy extends AbstractPaginatorProxy
	{
		public static const NAME:String 	= "PhotoBasketProxy";
		
		public function PhotoBasketProxy()
		{
			super(NAME);

		}
		
		override public function onRegister():void{
			pageSize = ApplicationConstants.PHOTO_BASKET_COLUMN_COUNT *
						ApplicationConstants.PHOTO_BASKET_ROW_COUNT;
		}
		
		override public function pageHandler(evt:PaginatorEvent):void{
			t.obj(evt.data, "paginator data in photoBasketProxy.pageHandler");
			sendNotification(ApplicationConstants.PHOTO_PAGINATOR_NOTIFICATION,evt.data);
		}
	}
}