package com.captionmashup.modules.core.login.model
{
	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.common.model.gateway.MainGateway;
	import com.captionmashup.common.model.local.dto.UserDTO;
	import com.captionmashup.common.model.proxy.UserProxy.AbstractUserProxy;
	import com.captionmashup.common.pipe.message.core.LoginMessage;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.login.facade.ApplicationConstants;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class LoginProxy extends AbstractUserProxy
	{
		public static const NAME:String = "LoginProxy";

		private var _token:AsyncToken;
		
		public function LoginProxy()
		{
			super(NAME);
			//_netConnection.connect("http://localhost:8000/gateway/");
		}
		
		override public function onUserLogin():void{
			var loginMessage:LoginMessage = new LoginMessage(LoginMessage.SET_USER_DATA,user);
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,loginMessage);
			sendNotification(ApplicationConstants.USER_RETRIEVED,user);
		}
		
		override public function onUserLogout():void{
			trace("LoginModule.LoginProxy.onUserLogout called");
			var loginMessage:LoginMessage = new LoginMessage(LoginMessage.SET_USER_DATA,null);
			sendNotification(ApplicationConstants.LOGOUT_COMPLETE);
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,loginMessage);
		}

		public function tryLogin(username:String,password:String,responder:AsyncResponder):void{
			_token = MainGateway.getAccountService().userLogin(username,password);
			_token.type = "TryLogin"
			_token.addResponder(responder);
		}
		
		public function logout(responder:AsyncResponder):void{
			_token = MainGateway.getAccountService().userLogout();
			_token.type = "Logout";
			_token.addResponder(responder);
		}
		
		public function retrieveUser(responder:AsyncResponder):void{
			_token = MainGateway.getAccountService().getUser();
			_token.type = "RetrieveUser";
			_token.addResponder(responder);
		}

	}
}