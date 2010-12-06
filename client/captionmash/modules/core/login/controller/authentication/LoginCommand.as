package com.captionmashup.modules.core.login.controller.authentication
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.model.local.dto.UserDTO;
	import com.captionmashup.common.pipe.message.core.LoginMessage;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.login.facade.ApplicationConstants;
	import com.captionmashup.modules.core.login.model.LoginProxy;
	import com.captionmashup.modules.core.login.view.LoginFormMediator;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class LoginCommand extends AbstractRPCCommand
	{
		private var loginProxy:LoginProxy;
		private var loginMediator:LoginFormMediator;
		
		override public function execute(notification:INotification):void
		{
			loginMediator 	= facade.retrieveMediator(LoginFormMediator.NAME) as LoginFormMediator;
			loginProxy 		= facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
			
			var username:String = loginMediator.loginForm.emailInput.text;
			var password:String = loginMediator.loginForm.passwordInput.text;
			
			loginProxy.tryLogin(username,password,asyncResponder);
	
		}

		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			//loginProxy.user = evt.result as UserDTO;
			loginProxy.user = evt.result as UserDTO;
			t.obj(evt.result,"result in loginCommand");
			loginMediator.loginForm.emailInput.text = "";
			loginMediator.loginForm.passwordInput.text = "";
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
			t.obj(evt.fault,"Login fault");
		}
	}
}