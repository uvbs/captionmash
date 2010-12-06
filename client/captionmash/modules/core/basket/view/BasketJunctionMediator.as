package com.captionmashup.modules.core.basket.view
{
	import com.captionmashup.common.pipe.PipeAwareModuleConstants;
	import com.captionmashup.common.pipe.message.core.BasketMessage;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.modules.core.basket.facade.ApplicationConstants;
	import com.captionmashup.modules.core.basket.facade.ApplicationFacade;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class BasketJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = "BasketJunctionMediator";
		
		private var basketContainerMediator:BasketContainerMediator;
		
		public function BasketJunctionMediator()
		{
			super(NAME, new Junction());
		}
		
		override public function onRegister():void{
			basketContainerMediator = facade.retrieveMediator(BasketContainerMediator.NAME) as BasketContainerMediator;
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
					trace("TEST_PIPE in BasketJunctionMediator"); 
					//sendNotification( ApplicationFacade.MESSAGE_FROM_SHELL_RECEIVED,Message(message).getBody() );
					break;
				
				case BasketMessage.SHOW:
					if(ApplicationFacade.isDisplayed) return;
					sendDisplayMessage();
					break;
				
				case BasketMessage.TOGGLE:
					if(ApplicationFacade.isDisplayed) 
						sendRemoveMessage();
					else
						sendDisplayMessage();
					break;
				
				case BasketMessage.REMOVE:
					if(!ApplicationFacade.isDisplayed) return;
					sendRemoveMessage();
					break;
				
				case BasketMessage.ADD_PHOTO:
					trace("handling add photo to basket in basketJunctionMediator");
					sendNotification(ApplicationConstants.ADD_PHOTO,message.getBody());
					break;
			}
		}//handlePipeMessage end
		
		private function sendDisplayMessage():void{
			var popupMessage:PopupMessage = new PopupMessage(PopupMessage.CREATE_POPUP,
													basketContainerMediator.basketContainer);
			junction.sendMessage(PipeAwareModuleConstants.STDOUT,popupMessage);
			ApplicationFacade.isDisplayed = true;
		}
		
		private function sendRemoveMessage():void{
			var popupMessage:PopupMessage = new PopupMessage(PopupMessage.REMOVE_POPUP,
													basketContainerMediator.basketContainer);
			junction.sendMessage(PipeAwareModuleConstants.STDOUT,popupMessage);
			ApplicationFacade.isDisplayed = false;
		}
	}
}