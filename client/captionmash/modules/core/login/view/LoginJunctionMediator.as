package com.captionmashup.modules.core.login.view
{
	import com.captionmashup.common.pipe.PipeAwareModuleConstants;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.common.pipe.message.core.LoginMessage;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.common.pipe.message.core.UploadMessage;
	import com.captionmashup.modules.core.login.facade.ApplicationConstants;
	import com.captionmashup.modules.core.login.model.LoginProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class LoginJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = 'LoginJunctionMediator';
		
		public function LoginJunctionMediator()
		{
			super( NAME, new Junction() );
		}
		
		/**
		 * Junction related Notification list.
		 * <P>
		 * Adds subclass interests to JunctionMediator interests.</P>
		 */
		override public function listNotificationInterests():Array
		{
			var interests:Array = super.listNotificationInterests();
			interests.push( ApplicationConstants.SEND_MESSAGE_TO_SHELL );
			return interests; 
		}
		
		/**
		 * Handle SimpleModule related Notifications.
		 */
		override public function handleNotification( note:INotification ):void
		{
			
			switch( note.getName() )
			{							
				case ApplicationConstants.SEND_MESSAGE_TO_SHELL:
					trace("Sending Message to Shell: "+note.getBody());
					junction.sendMessage(PipeAwareModuleConstants.STDOUT,note.getBody() as Message);
					break;				
				// Let super handle the rest (ACCEPT_OUTPUT_PIPE, ACCEPT_INPUT_PIPE, SEND_TO_LOG)								
				default:
					super.handleNotification(note);					
			}	
		}
		
		
		/**
		 * Handle incoming pipe messages from the Shell.
		 */
		override public function handlePipeMessage( message:IPipeMessage ):void
		{
			switch ( Message(message).getType() )
			{
				case DebugMessage.TEST_PIPE:
					trace("TEST_PIPE in LoginJunctionMediator"); 
					//sendNotification( ApplicationFacade.MESSAGE_FROM_SHELL_RECEIVED,Message(message).getBody() );
					break;
				
				case LoginMessage.TRY_LOGIN:
					var loginMediator:LoginFormMediator = facade.retrieveMediator(LoginFormMediator.NAME) as LoginFormMediator;

					junction.sendMessage(PipeAwareModuleConstants.STDOUT,
						new PopupMessage(PopupMessage.CREATE_MODAL_POPUP,loginMediator.loginForm));
					break;
				
				case LoginMessage.REGISTER:
					var registrationMediator:RegistrationFormMediator = facade.retrieveMediator(RegistrationFormMediator.NAME) 
																							as RegistrationFormMediator;
					junction.sendMessage(PipeAwareModuleConstants.STDOUT,
						new PopupMessage(PopupMessage.CREATE_MODAL_POPUP,registrationMediator.registrationForm));																
					break;
				
				case LoginMessage.GET_UI:
					sendNotification(ApplicationConstants.UI_QUERY);
					break;
				
				case LoginMessage.GET_USER_DATA:
					trace("LoginMessage.GET_USER_DATA received in LoginJunctionMediator");
					var loginProxy:LoginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
					var loginMessage:LoginMessage= new LoginMessage(LoginMessage.SET_USER_DATA,
																				loginProxy.getData());
					junction.sendMessage(PipeAwareModuleConstants.STDOUT,loginMessage);
					break;
				
			}
		}
	}
}