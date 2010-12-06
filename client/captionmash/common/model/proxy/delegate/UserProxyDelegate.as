package com.captionmashup.common.model.proxy.delegate
{
	import com.captionmashup.common.model.gateway.MainGateway;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	
	public class UserProxyDelegate
	{
		private var _token:AsyncToken;
		private var _responder:AsyncResponder;
		
		public function UserProxyDelegate(responder:AsyncResponder)
		{
			_responder = responder;	
		}
		
		public function getUsers():void{
			_token = MainGateway.getAccountService().getUsers();
			_token.type = "getUsers"
			_token.addResponder(_responder);
		}
				
	}
}