package com.captionmashup.modules.core.caption_browser.view
{
	import com.captionmashup.common.pipe.PipeAwareModuleConstants;
	import com.captionmashup.common.pipe.message.core.CaptionBrowserMessage;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.modules.core.caption_browser.facade.ApplicationConstants;
	import com.captionmashup.modules.core.caption_browser.facade.ApplicationFacade;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class CaptionBrowserJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = "CaptionBrowserJunctionMediator";
		private var captionBrowserMediator:CaptionBrowserMediator;
		
		public function CaptionBrowserJunctionMediator()
		{
			super(NAME, new Junction());
		}
		
		override public function onRegister():void{
			captionBrowserMediator = facade.retrieveMediator(CaptionBrowserMediator.NAME) 
																as CaptionBrowserMediator;
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
					trace("TEST_PIPE in CaptionBrowserJunctionMediator"); 
					//sendNotification( ApplicationFacade.MESSAGE_FROM_SHELL_RECEIVED,Message(message).getBody() );
					break;
				
				case CaptionBrowserMessage.GET_UI:
					trace("GET_UI message received in captionBrowserJunctionMediator");
					sendNotification(ApplicationConstants.UI_QUERY);
					break;
				
				case CaptionBrowserMessage.LATEST_CAPTIONS:
					sendNotification(ApplicationConstants.LATEST_CAPTIONS);
					break;
			}
		}//handlePipeMessage end
	}
}