package com.captionmashup.modules.album.local.model
{
	import com.captionmashup.common.model.proxy.UserProxy.AbstractUserProxy;
	
	public class UserProxy extends AbstractUserProxy
	{
		public static const NAME:String = "UserProxy";
		
		public function UserProxy()
		{
			super(NAME);
		}
		
		override public function onUserLogin():void{
			trace("User set in LocalAlbum.UserProxy");
		}
		
		override public function onUserLogout():void{
			trace("User logout in LocalAlbum.UserProxy");
		}
	}
}