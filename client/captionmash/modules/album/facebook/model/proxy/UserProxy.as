package com.captionmashup.modules.album.facebook.model.proxy
{
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.common.model.foreign.facebook.User;
	import com.captionmashup.common.model.gateway.FacebookGraphGateway;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	import sk.yoz.events.FacebookOAuthGraphEvent;
	
	import com.captionmashup.common.log.t;

	public class UserProxy extends Proxy
	{
		public static const NAME:String = 'UserProxy';
		

		public function UserProxy()
		{
			super(NAME, new User);
			//Listener for authorized
			FacebookGraphGateway.getConnection().addEventListener(FacebookOAuthGraphEvent.AUTHORIZED,onAuthorized);	
		}
		
		public function get user():User
		{
			return data as User;
		}
		
		public function popupLogin():void
		{
			trace("Login Popup from UserProxy");
			FacebookGraphGateway.getConnection().connect();
			//FacebookGraphGateway.getConnection().connect();
		}
		
		//Handle FacebookOAuthGraphEvent.AUTHORIZED event
		public function onAuthorized(evt:FacebookOAuthGraphEvent):void{
			trace("loginproxy authorized returned: "+evt.toString());
			sendNotification(ApplicationConstants.LOAD_USER_DATA);
			//ApplicationFacade.logged_in = true;
			//FacebookGraphGateway.call(ApplicationFacade.ME,false,onLoadUser);
			//sendNotification(ApplicationFacade.SN_ACCOUNT_VERIFIED);
		}

		//Loads user profile from Facebook(user_id etc), called from Command
		public function loadUser(callback:Function):void{
			FacebookGraphGateway.call(ApplicationConstants.ME,false,callback);
		}

		public function setUser(facebook_profile:Object):void{
			if (facebook_profile == null) return;
			this.data = new User(facebook_profile);
		}
	}
}