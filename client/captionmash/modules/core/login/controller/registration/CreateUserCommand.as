package com.captionmashup.modules.core.login.controller.registration
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.model.local.dto.UserDTO;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.login.model.LoginProxy;
	import com.captionmashup.modules.core.login.model.RegistrationProxy;
	import com.captionmashup.modules.core.login.view.RegistrationFormMediator;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class CreateUserCommand extends AbstractRPCCommand
	{
		private var registrationProxy:RegistrationProxy;
		private var loginProxy:LoginProxy;
		private var registrationMediator:RegistrationFormMediator;
		
		override public function execute(notification:INotification):void{
			trace("CreateUserCommand called");
			loginProxy 				= facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
			registrationProxy 		= facade.retrieveProxy(RegistrationProxy.NAME) as RegistrationProxy;
			registrationMediator 	= facade.retrieveMediator(RegistrationFormMediator.NAME) as RegistrationFormMediator;
		
			var email:String 	= registrationMediator.registrationForm.emailInput.text;
			var password:String = registrationMediator.registrationForm.passwordInput.text;
			var nickname:String	= registrationMediator.registrationForm.nicknameInput.text;
			trace("CreateUserCommand email: "+email );
			trace("CreateUserCommand password: "+password );
			trace("CreateUserCommand nickname: "+nickname );
			registrationProxy.createUser(email,password,nickname,asyncResponder);
		}
		
		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			loginProxy.user = evt.result as UserDTO;
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
			t.obj(evt.fault,"fault in CreateUserCommand");
		}
	}
}