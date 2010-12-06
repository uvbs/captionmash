package com.captionmashup.modules.core.login
{
	import com.captionmashup.common.pipe.PipeAwareModule;
	import com.captionmashup.modules.core.login.facade.ApplicationFacade;
	
	public class LoginModule extends PipeAwareModule
	{
		public static const NAME:String = "LoginModule";
	
		public function LoginModule()
		{
			super(ApplicationFacade.getInstance(NAME));
			ApplicationFacade(this.facade).startup(this);
		}
		
	}
}