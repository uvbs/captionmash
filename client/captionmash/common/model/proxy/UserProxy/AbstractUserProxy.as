package com.captionmashup.common.model.proxy.UserProxy
{
	import com.captionmashup.common.model.local.dto.UserDTO;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class AbstractUserProxy extends Proxy
	{
		public function AbstractUserProxy(proxyName:String=null)
		{
			super(proxyName, new UserDTO);
		}
		
		public function set user(userDTO:UserDTO):void{
			data = userDTO;
			if(userDTO == null){
				onUserLogout();
			}else{
				onUserLogin();
			}
		}
		
		public function get user():UserDTO{
			return data as UserDTO;
		}
		
		public function onUserLogin():void{
			throw new Error("onUserSet function must be set to send notification");
		}
		
		public function onUserLogout():void{
			throw new Error("onUserSet function must be set to send notification");
		}
	}
}