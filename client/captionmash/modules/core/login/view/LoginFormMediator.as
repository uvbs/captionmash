package com.captionmashup.modules.core.login.view
{
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.modules.core.login.facade.ApplicationConstants;
	import com.captionmashup.modules.core.login.model.FacebookLoginProxy;
	import com.captionmashup.modules.core.login.model.LoginProxy;
	import com.captionmashup.modules.core.login.view.components.LoginForm.LoginForm;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class LoginFormMediator extends Mediator
	{
		public static const NAME:String = "LoginFormMediator";
		
		private var loginProxy:LoginProxy;
		private var facebookLoginProxy:FacebookLoginProxy;
		
		public function LoginFormMediator(loginForm:LoginForm)
		{
			super(NAME, loginForm);

			loginForm.addEventListener(LoginForm.SUBMIT,onSubmit);
			loginForm.addEventListener(LoginForm.CANCEL,onCancel);
			loginForm.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		public function get loginForm():LoginForm{
			return viewComponent as LoginForm;
		}
		
		override public function onRegister():void{
			loginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
			facebookLoginProxy = facade.retrieveProxy(FacebookLoginProxy.NAME) as FacebookLoginProxy;
		}
		
		private function onSubmit(evt:Event):void{
			trace("LoginMediator onSubmit called");
			tryLogin();
		}
	
		private function onCancel(evt:Event):void{
			trace("LoginMediator Cancel called");
			removeLoginPopup();
			//loginProxy.loginTest();
		}
		
		private function onKeyDown(evt:KeyboardEvent):void{
			switch(evt.charCode){
				//Enter
				case 13:
					tryLogin();
					break;
				//Escape
				case 27:
					removeLoginPopup();
					break;
			}
		}
		
		private function tryLogin():void{
			sendNotification(ApplicationConstants.LOGIN);
			removeLoginPopup();
		}
		
		
		private function removeLoginPopup():void{
			sendMessageToShell(new PopupMessage(PopupMessage.REMOVE_POPUP,loginForm));
		}
		
		private function sendMessageToShell(message:Message):void{
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,message);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.POPUP_LOGIN,
			];
		}
		

		override public function handleNotification( notification:INotification ):void
		{
			
			switch( notification.getName() )
			{	
				case ApplicationConstants.POPUP_LOGIN:
					sendMessageToShell(new PopupMessage(PopupMessage.CREATE_MODAL_POPUP,loginForm));
					break;
				
			}	
		}
		
	}
}