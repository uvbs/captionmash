package com.captionmashup.modules.core.album_container.view
{
	import com.captionmashup.common.model.local.dto.UserDTO;
	import com.captionmashup.common.pipe.PipeAwareModuleConstants;
	import com.captionmashup.common.pipe.message.album.FacebookMessage;
	import com.captionmashup.common.pipe.message.album.LocalAlbumMessage;
	import com.captionmashup.common.pipe.message.core.AlbumContainerMessage;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.common.pipe.message.core.LoginMessage;
	import com.captionmashup.modules.core.album_container.facade.ApplicationConstants;
	import com.captionmashup.modules.core.album_container.model.UserProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class AlbumContainerJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = "AlbumContainerJunctionMediator";
		private var userProxy:UserProxy;
		
		public function AlbumContainerJunctionMediator()
		{
			super(NAME, new Junction());
		}
		
		override public function onRegister():void{
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
					trace("TEST_PIPE in AlbumContainerJunctionMediator"); 
					break;
				
				case LocalAlbumMessage.SET_UI:
					trace("LocalAlbumMessage.SET_UI received in AlbumContainerJunctionMediator");
					sendNotification(ApplicationConstants.SET_LOCAL_ALBUM_BROWSER_UI,message.getBody());
					break;
				
				case FacebookMessage.SET_UI:
					sendNotification(ApplicationConstants.SET_FACEBOOK_UI,message.getBody());
					break;
				
				case AlbumContainerMessage.GET_UI:
					trace("AlbumContainerMessage.GET_UI received in AlbumContainerModule");
					sendNotification(ApplicationConstants.UI_QUERY);
					break;
				
				case LoginMessage.SET_USER_DATA:
					userProxy.user = message.getBody() as UserDTO;
					break;

			}
		}//handlePipeMessage end
	}
}