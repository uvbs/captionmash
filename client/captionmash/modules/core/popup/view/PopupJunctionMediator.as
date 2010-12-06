package com.captionmashup.modules.core.popup.view
{
	import com.captionmashup.common.pipe.PipeAwareModuleConstants;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.modules.core.popup.facade.ApplicationConstants;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class PopupJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = "PopupJunctionMediator";
		
		public function PopupJunctionMediator()
		{
			super(NAME, new Junction());
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
					//junction.sendMessage(PipeAwareModuleConstants.STDSHELL,new CreatorMessage(note.getBody() as String));
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
					trace("TEST_PIPE in PopupJunctionMediator"); 
					break;
				
				case PopupMessage.CREATE_POPUP:
					sendNotification(ApplicationConstants.CREATE_POPUP,message.getBody());
					trace("Create Popup message received in popupmodule");
					break;
				
				case PopupMessage.CREATE_MODAL_POPUP:
					sendNotification(ApplicationConstants.CREATE_MODAL_POPUP,message.getBody());
					trace("Create Modal Popup message received in popupmodule");
					break;
				
				case PopupMessage.REMOVE_POPUP:
					trace("Remove Popup message received in popupmodule");
					sendNotification(ApplicationConstants.REMOVE_POPUP,message.getBody());
					break;
					
			}
		}//handlePipeMessage end
	}
}