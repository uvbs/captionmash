package com.captionmashup.modules.core.debug
{
	import com.captionmashup.common.pipe.PipeAwareModule;
	import com.captionmashup.modules.core.debug.facade.ApplicationFacade;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	
	public class DebugModule extends PipeAwareModule
	{
		public static const NAME:String = "DebugModule";
		
		public function DebugModule()
		{
			super(ApplicationFacade.getInstance(NAME));
			ApplicationFacade(this.facade).startup(this);
		}
	}
}