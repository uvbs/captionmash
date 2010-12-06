
package com.captionmashup.modules.core.creator.view
{
	import com.captionmashup.common.model.local.dto.UserDTO;
	import com.captionmashup.common.pipe.PipeAwareModuleConstants;
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.common.pipe.message.core.LoginMessage;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.creator.facade.ApplicationConstants;
	import com.captionmashup.modules.core.creator.model.UserProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Pipe;
	
	public class CreatorJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = 'CreatorJunctionMediator';
		private var userProxy:UserProxy;
		
		public function CreatorJunctionMediator( )
		{
			super( NAME, new Junction() );
		}

		/**
		 * Called when the Mediator is registered.
		 */
		override public function onRegister():void
		{
			userProxy		 	= 	facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			//sendNotification(ApplicationFacade.SEND_MESSAGE_TO_SHELL,CreatorMessage.RETRIEVE_ACTIVE_CONTENT);		
		}
		/**
		 * Remove event listeners
		 */
		override public function onRemove():void
		{
			trace("CreatorJunctionMediator.onRemove called");
			//
			// remove both pipes (shell -> module && module -> shell )			
			junction.removePipe( PipeAwareModuleConstants.STDIN );
			junction.removePipe( PipeAwareModuleConstants.STDOUT);
			junction.removePipe( PipeAwareModuleConstants.STDSHELL);		
		}		
		/**
		 * ShellJunction related Notification list.
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
					junction.sendMessage(PipeAwareModuleConstants.STDOUT, note.getBody() as Message);
					/*junction.sendMessage( PipeAwareModuleConstants.MODULE_TO_SHELL_PIPE,
											new Message( PipeAwareModuleConstants.MODULE_TO_SHELL_MESSAGE,
															null,
															note.getBody() ));*/
					//junction.sendMessage( PipeAwareModuleConstants.MODULE_TO_SHELL_PIPE,new CreatorMessage(CreatorMessage.END_CREATE));
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
					trace("TEST_PIPE in CreatorJunctionMediator"); 
					//sendNotification( ApplicationFacade.MESSAGE_FROM_SHELL_RECEIVED,Message(message).getBody() );
					break;
				
				case LoginMessage.SET_USER_DATA:
					trace("setting user data in uploadJunctionMediator");
					userProxy.user = message.getBody() as UserDTO;
					break;
				
				case CreatorMessage.START_CREATE:
					trace("handling CreatorMessage.START_CREATE in CreatorJunctionMediator"); 
					sendNotification( ApplicationConstants.START_CREATION,message);
					//t.obj(Message(message).getBody(),"Message(message).getBody()");
					break;
				
				case CreatorMessage.GET_UI:
					sendNotification( ApplicationConstants.UI_QUERY);
					break;
				//case CreatorMessage
			}
		}
	}
}