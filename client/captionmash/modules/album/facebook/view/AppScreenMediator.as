package com.captionmashup.modules.album.facebook.view
{
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.modules.album.facebook.model.proxy.UserProxy;
	import com.captionmashup.modules.album.facebook.view.components.AppScreen.AppScreen;
	import com.captionmashup.modules.album.facebook.view.components.LoginScreen.LoginScreen;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class AppScreenMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'AppScreenMediator';
		
		private var accountProxy:UserProxy;
		
		public function AppScreenMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			appScreen.loginScreen.addEventListener(LoginScreen.TRY_LOGIN,onTryLogin);
		}
		
		override public function onRegister():void{
			trace("Retrieving userproxy in AppScreenMediator");
			accountProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			trace("onRegister UserProxy check :"+accountProxy);
		}
		
		public function get appScreen():AppScreen{
			return viewComponent as AppScreen;
		}
		
		//Handle login request
		private function onTryLogin(evt:Event):void{
			trace("onTryLogin UserProxy check :"+accountProxy);
			accountProxy.popupLogin();
			//sendNotification(ApplicationConstants.TRY_LOGIN);
		}
	}
}