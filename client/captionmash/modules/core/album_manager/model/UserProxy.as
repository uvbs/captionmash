package com.captionmashup.modules.core.album_manager.model
{
	import com.captionmashup.common.model.proxy.UserProxy.AbstractUserProxy;
	import com.captionmashup.modules.core.album_manager.facade.ApplicationConstants;
	
	public class UserProxy extends AbstractUserProxy
	{
		public static const NAME:String = "UserProxy";
		
		public function UserProxy()
		{
			super(NAME);
		}
		
		override public function onUserLogin():void{
			trace("User set in UploadModule.UserProxy");
		}
		
		override public function onUserLogout():void{
			trace("User logout in UploadModule.UserProxy");
			sendNotification(ApplicationConstants.USER_LOGOUT);
		}
	}
}