package com.captionmashup.modules.core.login.model
{
	import com.captionmashup.common.model.foreign.facebook.User;
	import com.captionmashup.common.model.gateway.FacebookGraphGateway;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	import sk.yoz.events.FacebookOAuthGraphEvent;
	
	public class FacebookLoginProxy extends Proxy
	{
		public static const NAME:String = 'FacebookLoginProxy';
		
		public function FacebookLoginProxy()
		{
			super(NAME, new User);
			//Listener for authorized
			FacebookGraphGateway.getConnection().addEventListener(FacebookOAuthGraphEvent.AUTHORIZED,onAuthorized);	
		}
		
		public function popupLogin():void
		{
			trace("Login Popup from FacebookLoginProxy");
			FacebookGraphGateway.getConnection().connect();
			//FacebookGraphGateway.getConnection().connect();
		}
		
		//Handle FacebookOAuthGraphEvent.AUTHORIZED event
		public function onAuthorized(evt:FacebookOAuthGraphEvent):void{
			trace("FacebookLoginProxy authorized returned: "+evt.toString());
			FacebookGraphGateway.getConnection().removeEventListener(FacebookOAuthGraphEvent.AUTHORIZED,onAuthorized);
		}
	}
}