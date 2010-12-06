package com.captionmashup.modules.core.login.model
{
	import com.captionmashup.common.model.gateway.MainGateway;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class RegistrationProxy extends Proxy
	{
		public static const NAME:String = "RegistrationProxy";
		private var _token:AsyncToken;
		
		public function RegistrationProxy()
		{
			super(NAME,new Object);
		}
		
		public function createUser(email:String,password:String,
								   nickname:String,responder:AsyncResponder):void{
			_token = MainGateway.getAccountService().createUser(email,password,nickname);	
			_token.type = "createUser"
			_token.addResponder(responder);
		}
		
		public function checkUniqueEmail(email:String,responder:AsyncResponder):void{
			_token = MainGateway.getAccountService().checkEmail(email);	
			_token.type = "checkEmail";
			_token.addResponder(responder);
		}
		
		public function checkUniqueNickname(nickname:String,responder:AsyncResponder):void{
			_token = MainGateway.getAccountService().checkNickname(nickname);	
			_token.type = "checkNickname";
			_token.addResponder(responder);
		}
		
	}
}