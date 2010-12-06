package com.captionmashup.modules.core.basket
{
	import com.captionmashup.common.pipe.PipeAwareModule;
	import com.captionmashup.modules.core.basket.facade.ApplicationFacade;
	
	public class BasketModule extends PipeAwareModule
	{
		public static const NAME:String = "BasketModule";
		
		public function BasketModule()
		{
			super(ApplicationFacade.getInstance(NAME));
			ApplicationFacade(this.facade).startup(this);
		}
		
	}
}