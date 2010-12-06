package com.captionmashup.modules.core.caption_browser
{
	import com.captionmashup.common.pipe.PipeAwareModule;
	import com.captionmashup.modules.core.caption_browser.facade.ApplicationFacade;
	
	public class CaptionBrowserModule extends PipeAwareModule
	{
		public static const NAME:String = "CaptionBrowserModule";
		
		public function CaptionBrowserModule()
		{
			super(ApplicationFacade.getInstance(NAME));
			ApplicationFacade(this.facade).startup(this);
		}
		
	}
}