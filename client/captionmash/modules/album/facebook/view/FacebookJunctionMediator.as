package com.captionmashup.modules.album.facebook.view
{
	import com.captionmashup.common.pipe.PipeAwareModuleConstants;
	import com.captionmashup.common.pipe.message.album.FacebookMessage;
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Pipe;
	
	public class FacebookJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = 'FacebookJunctionMediator';
		
		public function FacebookJunctionMediator( )
		{
			super( NAME, new Junction() );
		}
		
		/**
		 * Called when the Mediator is registered.
		 */
		override public function onRegister():void
		{
			//sendNotification(ApplicationFacade.SEND_MESSAGE_TO_SHELL,CreatorMessage.RETRIEVE_ACTIVE_CONTENT);		
		}
		/**
		 * Remove event listeners
		 */
		override public function onRemove():void
		{
			//
			// remove both pipes (shell -> module && module -> shell )			
			junction.removePipe( PipeAwareModuleConstants.STDIN );
			junction.removePipe( PipeAwareModuleConstants.STDOUT);		
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
					trace("TEST_PIPE in FacebookJunctionMediator"); 
					//sendNotification( ApplicationFacade.MESSAGE_FROM_SHELL_RECEIVED,Message(message).getBody() );
					break;
				
				case FacebookMessage.GET_UI:
					sendNotification(ApplicationConstants.UI_QUERY);
					break;
				//case CreatorMessage
			}
		}
	}
}