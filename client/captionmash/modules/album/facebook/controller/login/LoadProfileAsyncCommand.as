package com.captionmashup.modules.album.facebook.controller.login
{
	import com.captionmashup.modules.album.facebook.model.proxy.UserProxy;
	import com.captionmashup.modules.album.facebook.view.AppScreenMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.AsyncCommand;
	
	import sk.yoz.events.FacebookOAuthGraphEvent;
	
	import com.captionmashup.common.log.t;
	
	public class LoadProfileAsyncCommand extends AsyncCommand
	{
		private var userProxy:UserProxy;

		override public function execute ( note:INotification ) : void
		{
			trace("LoadProfileAsyncCommand called");
			userProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			var appScreenMediator:AppScreenMediator = facade.retrieveMediator(AppScreenMediator.NAME) as AppScreenMediator;
			appScreenMediator.appScreen.removeElement(appScreenMediator.appScreen.loginScreen);
			appScreenMediator.appScreen.removeElement(appScreenMediator.appScreen.startupScreen);
			//Load profile
			userProxy.loadUser(onLoadUser);
		}
		
		//Handler
		private function onLoadUser(evt:FacebookOAuthGraphEvent):void
		{
			userProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;

			//t.obj(evt.data,"Profile data in LoadProfileAsyncCommand.onLoadUser");
			//Set user data
			userProxy.setUser(evt.data);
			commandComplete();
		}
	}
}