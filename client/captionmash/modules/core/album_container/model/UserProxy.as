package com.captionmashup.modules.core.album_container.model
{
	import com.captionmashup.common.model.proxy.UserProxy.AbstractUserProxy;
	import com.captionmashup.modules.core.album_container.facade.ApplicationConstants;
	
	public class UserProxy extends AbstractUserProxy
	{
		public static const NAME:String = "UserProxy";
		
		public function UserProxy()
		{
			super(NAME);
		}
		
		override public function onUserLogin():void{
			sendNotification(ApplicationConstants.USER_LOGIN,user);
		}
		
		
		override public function onUserLogout():void{
			sendNotification(ApplicationConstants.USER_LOGOUT);
		}
	}
}