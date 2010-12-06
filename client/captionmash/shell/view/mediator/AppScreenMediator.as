package com.captionmashup.shell.view.mediator
{
	import com.captionmashup.common.model.local.dto.UserDTO;
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.shell.facade.ShellConstants;
	import com.captionmashup.shell.facade.ShellFacade;
	import com.captionmashup.shell.view.components.AppScreen.AppControlBar;
	import com.captionmashup.shell.view.components.AppScreen.AppScreen;
	
	import flash.events.Event;
	
	import mx.core.IVisualElement;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.statemachine.StateMachine;
	
	/**************************
	 * TODO Turn this into shell mediator
	 * ************************/	
	public class AppScreenMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'AppScreenMediator';
		public var creatorModuleLoaded:Boolean = false;
		
		public function AppScreenMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			appScreen.addEventListener(AppControlBar.CAPTIONS,	onCaptions);
			appScreen.addEventListener(AppControlBar.IMAGES,	onImages);
			appScreen.addEventListener(AppControlBar.CREATE,	onCreate);
			appScreen.addEventListener(AppControlBar.DEBUG,	onDebug);
			//appScreen.addEventListener(AppControlBar.LOGIN,		onLogin);
			//appScreen.addEventListener(AppControlBar.LOGOUT,	onLogout);
			//appScreen.addEventListener(AppControlBar.REGISTER_ACCOUNT,	onRegisterAccount);
		}
		
		override public function onRegister () : void
		{
			trace("appScreenMediator onRegister called");
			//sendNotification(ShellNotifications.APP_INIT_COMPLETE);
			appScreen.viewStack.selectedIndex = 0;
		}
		
		//Event Handlers
		private function onCaptions(evt:Event):void{
			ShellFacade.is_browser_default_refresh = true;
			sendNotification(StateMachine.ACTION,null,ShellConstants.ACTION_BROWSE_CAPTIONS);
		}
		
		private function onImages(evt:Event):void{
			//appScreen.viewStack.selectedIndex = 1;
			sendNotification(StateMachine.ACTION,null,ShellConstants.ACTION_BROWSE_ALBUMS);
		}
		
		private function onCreate(evt:Event):void{
			var message:CreatorMessage = new CreatorMessage(CreatorMessage.START_CREATE);
			sendNotification(StateMachine.ACTION,message,ShellConstants.ACTION_START_CREATE);
		}
		
		private function onDebug(evt:Event):void{
			var message:DebugMessage = new DebugMessage(DebugMessage.SHOW);
			sendNotification(ShellConstants.SEND_MESSAGE_TO_MODULE,message);
		}

		
		
		private function testFunc(evt:Event):void{
			
			trace("Event AppControlBar: "+evt.type);
			/*if(evt.newIndex == 2){
				var message:CreatorMessage = new CreatorMessage(CreatorMessage.START_CREATE);
				sendNotification(StateMachine.ACTION,message,ShellConstants.START_CREATE);
			}
			if(evt.newIndex == 3){
				sendNotification(ShellConstants.SEND_MESSAGE_TO_MODULE,
					new DebugMessage(DebugMessage.SHOW));
				sendNotification(ShellConstants.SEND_MESSAGE_TO_MODULE,
					new DebugMessage(DebugMessage.LOG,"test header","test body"));
			}
			if(evt.newIndex == 6){
				sendNotification(StateMachine.ACTION,new LoginMessage(LoginMessage.REGISTER),ShellConstants.START_LOGIN);
			}*/
		}
		
		public function get appScreen():AppScreen{
			return viewComponent as AppScreen;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ShellConstants.ADD_CAPTION_BROWSER,
				ShellConstants.ADD_ALBUM_CONTAINER,
				ShellConstants.ADD_LOGIN_BAR,
				ShellConstants.ADD_CREATOR,
				ShellConstants.USER_RECEIVED,
			];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{	                	
				case ShellConstants.ADD_CAPTION_BROWSER:
					appScreen.captionBrowserContainer.addElement(note.getBody() as IVisualElement);
					break;
				
				case ShellConstants.ADD_ALBUM_CONTAINER:
					appScreen.albumMenuContainer.addElement(note.getBody() as IVisualElement);
					break;
				
				case ShellConstants.ADD_CREATOR:
					appScreen.creatorContainer.addElement(note.getBody() as IVisualElement);
					break;
				
				case ShellConstants.ADD_LOGIN_BAR:
					trace("Adding loginBar in AppScreenMediator: "+note.getBody());
					appScreen.appControlBar.loginBarContainer.addElement(note.getBody() as IVisualElement);
					break;
				
				case ShellConstants.USER_RECEIVED:
					var user:UserDTO = note.getBody() as UserDTO;
					if(user == null) return;
					if(user.is_superuser) appScreen.appControlBar.debugButton.visible = true;					
					break;
			}
		}
	}
}