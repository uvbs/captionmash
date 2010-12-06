package com.captionmashup.modules.core.login.controller.startup
{
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.modules.core.login.LoginModule;
	import com.captionmashup.modules.core.login.facade.ApplicationConstants;
	import com.captionmashup.modules.core.login.view.LoginBarMediator;
	import com.captionmashup.modules.core.login.view.LoginJunctionMediator;
	import com.captionmashup.modules.core.login.view.LoginFormMediator;
	import com.captionmashup.modules.core.login.view.RegistrationFormMediator;
	import com.captionmashup.modules.core.login.view.components.LoginBar.LoginBar;
	import com.captionmashup.modules.core.login.view.components.LoginForm.LoginForm;
	import com.captionmashup.modules.core.login.view.components.RegistrationForm.RegistrationForm;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("LOGIN VIEWPREP COMMAND CALLED");
			
			var app:LoginModule= notification.getBody() as LoginModule;
			
			facade.registerMediator(new LoginJunctionMediator());
			facade.registerMediator(new LoginFormMediator(new LoginForm));
			facade.registerMediator(new RegistrationFormMediator(new RegistrationForm));
			facade.registerMediator(new LoginBarMediator(new LoginBar));
		}
	}
}