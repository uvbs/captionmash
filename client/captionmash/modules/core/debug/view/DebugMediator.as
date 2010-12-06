package com.captionmashup.modules.core.debug.view
{
	import com.captionmashup.common.pipe.message.core.BasketMessage;
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.common.pipe.message.core.LoginMessage;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.common.pipe.message.core.UploadMessage;
	import com.captionmashup.modules.core.debug.facade.ApplicationConstants;
	import com.captionmashup.modules.core.debug.view.components.DebugPanel.DebugPanel;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class DebugMediator extends Mediator
	{
		public static const NAME:String = "DebugMediator";
		
		public function DebugMediator(viewComponent:DebugPanel)
		{
			super(NAME, viewComponent);
			debugPanel.initialize();
			debugPanel.logger.initialize();
			
			debugPanel.addEventListener(DebugPanel.GET_USER,handler);
			debugPanel.addEventListener(DebugPanel.LATEST_CAPTIONS,handler);
			debugPanel.addEventListener(DebugPanel.LOGIN,handler);
			debugPanel.addEventListener(DebugPanel.LOGOUT,handler);
			debugPanel.addEventListener(DebugPanel.REGISTER,handler);
			debugPanel.addEventListener(DebugPanel.START_CREATION,handler);
			debugPanel.addEventListener(DebugPanel.TOGGLE_BASKET,handler);
			debugPanel.addEventListener(DebugPanel.UPLOAD_PHOTO,handler);
			debugPanel.addEventListener(DebugPanel.USER_ALBUMS,handler);
			
			
			debugPanel.addEventListener(DebugPanel.TEST_PIPES,handler);
			debugPanel.addEventListener(DebugPanel.CLOSE_DEBUG_PANEL,handler);
			
		}
		
		public function get debugPanel():DebugPanel{
			return viewComponent as DebugPanel;
		}
		
		private function handler(evt:Event):void{
			var message:Message;
			
			switch(evt.type)
			{
				case DebugPanel.GET_USER:
					message = new LoginMessage(LoginMessage.GET_USER_DATA);
					break;
				case DebugPanel.LOGIN:
					message = new LoginMessage(LoginMessage.TRY_LOGIN);
					break;
				case DebugPanel.LOGOUT:
				 	trace("DEBUGMEDIATOR: logout must be implemented in loging module");
					return;
					break;
				case DebugPanel.REGISTER:
					message = new LoginMessage(LoginMessage.REGISTER);
					break;
				case DebugPanel.START_CREATION:
					if(debugPanel.creatorData.text == ""){
						message = new CreatorMessage(CreatorMessage.START_CREATE);	
					}else{
						message = new CreatorMessage(CreatorMessage.START_CREATE,debugPanel.creatorData.text,CreatorMessage.HEADER_PHOTO_LINK);
					}
					
					break;
				case DebugPanel.TOGGLE_BASKET:
					message = new BasketMessage(BasketMessage.TOGGLE);
					break;
				case DebugPanel.UPLOAD_PHOTO:
					message = new UploadMessage(UploadMessage.SHOW);
					break;
				case DebugPanel.USER_ALBUMS:
					trace("DEBUGMEDIATOR: USER_ALBUMS must be implemented in local_album module");
					return;
					break;
				case DebugPanel.LATEST_CAPTIONS:
					trace("DEBUGMEDIATOR: CaptionBrowser module must be implemented");
					return;
					break;
				case DebugPanel.CLOSE_DEBUG_PANEL:
					message = new PopupMessage(PopupMessage.REMOVE_POPUP,debugPanel);
					break;
				
				case DebugPanel.TEST_PIPES:
					message = new DebugMessage(DebugMessage.TEST_PIPE);
					break;
			}
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,message);
		}
	}
}