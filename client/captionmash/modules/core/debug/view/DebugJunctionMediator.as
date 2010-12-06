package com.captionmashup.modules.core.debug.view
{
	import com.captionmashup.common.pipe.PipeAwareModuleConstants;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.debug.facade.ApplicationConstants;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class DebugJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = "DebugJunctionMediator";
		private var debugMediator:DebugMediator;
		
		public function DebugJunctionMediator()
		{
			super(NAME, new Junction());
		}
		
		override public function onRegister():void{
			debugMediator = facade.retrieveMediator(DebugMediator.NAME) as DebugMediator;	
		}
		
		/**
		 * Remove event listeners
		 */
		override public function onRemove():void
		{
			//
			// remove both pipes (shell -> module && module -> shell )			
			junction.removePipe( PipeAwareModuleConstants.STDIN );
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
				case DebugMessage.SHOW:
					trace("Handling DebugMessage.SHOW in debug junction mediator");
					junction.sendMessage(PipeAwareModuleConstants.STDOUT,
						new PopupMessage(PopupMessage.CREATE_POPUP,debugMediator.debugPanel));
					break;
				
				case DebugMessage.LOG:
					t.obj(message,"DebugMessage.LOG received in DebugJunctionMediator");
					debugMediator.debugPanel.logger.log(message);
					break;

			}
		}//handlePipeMessage end
	}
}