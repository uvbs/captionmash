package com.captionmashup.modules.core.album_manager.view
{
	import com.captionmashup.common.model.local.dto.UserDTO;
	import com.captionmashup.common.pipe.PipeAwareModuleConstants;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.common.pipe.message.core.LoginMessage;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.common.pipe.message.core.UploadMessage;
	import com.captionmashup.modules.core.album_manager.facade.ApplicationConstants;
	import com.captionmashup.modules.core.album_manager.model.UserProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class AlbumManagerJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = "UploadJunctionMediator";
		private var uploadPopupMediator:AlbumManagerMediator;
		private var userProxy:UserProxy;
		
		public function AlbumManagerJunctionMediator()
		{
			super(NAME, new Junction());
		}
		
		override public function onRegister():void{
			uploadPopupMediator = 	facade.retrieveMediator(AlbumManagerMediator.NAME) as AlbumManagerMediator;
			userProxy		 	= 	facade.retrieveProxy(UserProxy.NAME) as UserProxy;
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
					trace("TEST_PIPE in UploadJunctionMediator"); 
					break;
				
				case UploadMessage.SHOW:
					sendNotification(ApplicationConstants.GET_USER_ALBUMS);
					var popupMessage:PopupMessage = new PopupMessage(PopupMessage.CREATE_MODAL_POPUP,
						uploadPopupMediator.uploadPopup);
					junction.sendMessage(PipeAwareModuleConstants.STDOUT,popupMessage);
					break;
				
				case LoginMessage.SET_USER_DATA:
					trace("setting user data in uploadJunctionMediator");
					userProxy.user = message.getBody() as UserDTO;
					break;
			}
		}//handlePipeMessage end
	}
}
