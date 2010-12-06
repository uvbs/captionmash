package com.captionmashup.modules.core.viewer.view
{
	import com.captionmashup.common.pipe.PipeAwareModuleConstants;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.common.pipe.message.core.ViewerMessage;
	import com.captionmashup.modules.core.viewer.facade.ApplicationConstants;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class ViewerJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = "ViewerJunctionMediator";
		
		public function ViewerJunctionMediator()
		{
			super(NAME, new Junction());
		}
		
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
					trace("TEST_PIPE in ViewerJunctionMediator"); 
					break;
				
				case ViewerMessage.START_VIEW:
					trace("ViewerMessage.START_VIEW in ViewerJunctionMediator");
					sendNotification(ApplicationConstants.START_VIEW,message.getBody());
					break;
				
				case ViewerMessage.GET_CAPTION:
					trace("ViewerMessage.START_VIEW in ViewerJunctionMediator");
					sendNotification(ApplicationConstants.GET_CAPTION,message.getBody());
					break;
			}
		}//handlePipeMessage end
	}
}