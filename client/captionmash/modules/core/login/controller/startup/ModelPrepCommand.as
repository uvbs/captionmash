package com.captionmashup.modules.core.login.controller.startup
{

	import com.captionmashup.modules.core.login.model.FacebookLoginProxy;
	import com.captionmashup.modules.core.login.model.LoginProxy;
	import com.captionmashup.modules.core.login.model.RegistrationProxy;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ModelPrepCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			trace("LOGIN MODELPREP COMMAND CALLED");
			// register proxy
			facade.registerProxy(new RegistrationProxy());
			facade.registerProxy(new LoginProxy());
			facade.registerProxy(new FacebookLoginProxy());

		}
	}
}