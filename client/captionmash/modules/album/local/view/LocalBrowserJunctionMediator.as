package com.captionmashup.modules.album.local.view
{
	import com.captionmashup.common.model.local.dto.UserDTO;
	import com.captionmashup.common.pipe.PipeAwareModuleConstants;
	import com.captionmashup.common.pipe.message.album.LocalAlbumMessage;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.common.pipe.message.core.LoginMessage;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	import com.captionmashup.modules.album.local.facade.ApplicationFacade;
	import com.captionmashup.modules.album.local.model.UserProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class LocalBrowserJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = "LocalBrowserJunctionMediator";
		private var browserMediator:BrowserMediator;
		private var userProxy:UserProxy;
		
		public function LocalBrowserJunctionMediator()
		{
			super(NAME, new Junction());
		}
		
		override public function onRegister():void{
			browserMediator = facade.retrieveMediator(BrowserMediator.NAME) as BrowserMediator;
			userProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;	
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
					trace("TEST_PIPE in LocalAlbumJunctionMediator"); 
					//sendNotification( ApplicationFacade.MESSAGE_FROM_SHELL_RECEIVED,Message(message).getBody() );
					break;
				
				case LocalAlbumMessage.GET_UI:
					trace("LocalAlbumMessage.GET_UI received in LocalAlbumJunctionMediator");
					sendNotification(ApplicationConstants.UI_QUERY);
					break;

				
				case LocalAlbumMessage.LIST_GENRES:
					sendNotification(ApplicationConstants.LIST_GENRES,message.getBody());
					break;
				
				case LocalAlbumMessage.LIST_MEMBERS:
					sendNotification(ApplicationConstants.LIST_MEMBERS,message.getBody());
					break;
				
				case LocalAlbumMessage.LIST_USER_ALBUMS:
					sendNotification(ApplicationConstants.LIST_USER_ALBUMS,message.getBody());
					break;
				
				case LoginMessage.SET_USER_DATA:
					userProxy.user = message.getBody() as UserDTO;
					break;

			}
		}//handlePipeMessage end
	}
}