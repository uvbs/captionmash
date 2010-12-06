package com.captionmashup.modules.core.creator.model
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
			trace("User set in CreatorModule.UserProxy");
		}
		
		override public function onUserLogout():void{
			trace("User logout in CreatorModule.UserProxy");
		}
	}
}