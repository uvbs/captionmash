package com.captionmashup.modules.core.basket.model
{
	import com.captionmashup.common.model.proxy.PaginatorProxy.AbstractPaginatorProxy;
	
	public class BasketProxy extends AbstractPaginatorProxy
	{
		public static const NAME:String = "BasketProxy";
		
		public function BasketProxy()
		{
			super(NAME);
		}
	}
}