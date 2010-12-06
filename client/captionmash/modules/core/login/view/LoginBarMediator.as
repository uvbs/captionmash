package com.captionmashup.modules.core.login.view
{
	import com.captionmashup.common.model.local.dto.UserDTO;
	import com.captionmashup.modules.core.login.facade.ApplicationConstants;
	import com.captionmashup.modules.core.login.view.components.LoginBar.LoginBar;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class LoginBarMediator extends Mediator
	{
		public static const NAME:String = "LoginBarMediator";
		
		public function LoginBarMediator(viewComponent:LoginBar)
		{
			super(NAME, viewComponent);
			loginBar.initialize();
			
			loginBar.addEventListener(LoginBar.LOGIN,onLogin);
			loginBar.addEventListener(LoginBar.LOGOUT,onLogout);
			loginBar.addEventListener(LoginBar.REGISTER_ACCOUNT,onRegisterAccount);
			
			loginBar.currentState = LoginBar.LOGGED_IN_STATE;
			
		}
		
		public function get loginBar():LoginBar{
			return viewComponent as LoginBar;
		}
		
		
		private function onLogin(evt:Event):void{
			trace("LoginBarMediator onLogin called");	
			sendNotification(ApplicationConstants.POPUP_LOGIN);
		}
		
		private function onLogout(evt:Event):void{
			trace("LoginBarMediator onLogout called");
			sendNotification(ApplicationConstants.LOGOUT);
		}
		
		private function onRegisterAccount(evt:Event):void{
			trace("LoginBarMediator onRegisterAccount called");	
			sendNotification(ApplicationConstants.POPUP_REGISTRATION);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.USER_RETRIEVED,
				ApplicationConstants.LOGIN,
				ApplicationConstants.LOGOUT_COMPLETE,
			];
		}
		
		
		override public function handleNotification( notification:INotification ):void
		{
			
			switch( notification.getName() )
			{	
				case ApplicationConstants.USER_RETRIEVED:
					var user:UserDTO = notification.getBody() as UserDTO;
					loginBar.currentState = LoginBar.LOGGED_IN_STATE;
					loginBar.validateNow();
					loginBar.username.initialize(); //This thing keeps throwing null exception
					trace("Loginbar.username label: "+loginBar.username);
					trace("Loginbar.username.text label: "+loginBar.username.text);
					loginBar.username.text = user.nickname;
					
					break;
				
				case ApplicationConstants.LOGOUT_COMPLETE:
					loginBar.currentState = LoginBar.LOGGED_OUT_STATE;
					break;
				
				case ApplicationConstants.LOGIN:
					loginBar.currentState = LoginBar.RETRIEVING_USER_STATE;
					break;
				
			}	
		}
	}
}