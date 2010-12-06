package com.captionmashup.modules.core.viewer
{
	import com.captionmashup.common.pipe.PipeAwareModule;
	import com.captionmashup.modules.core.viewer.facade.ApplicationFacade;
	
	public class ViewerModule extends PipeAwareModule
	{
		public static const NAME:String = "ViewerModule";
	
		public function ViewerModule()
		{
			super(ApplicationFacade.getInstance(NAME));
			ApplicationFacade(this.facade).startup(this);
		}
		
	}
}