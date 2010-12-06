package com.captionmashup.modules.core.popup
{
	import com.captionmashup.common.pipe.PipeAwareModule;
	import com.captionmashup.modules.core.popup.facade.ApplicationFacade;

	public class PopupModule extends PipeAwareModule
	{
		public static const NAME:String = "PopupModule";
		
		public static const POPUP_WINDOW_UI:String = "PopupWindowUI";
		
		public function PopupModule()
		{
			super(ApplicationFacade.getInstance(NAME));
			ApplicationFacade(this.facade).startup(this);
		}
		
	}
}