package com.captionmashup.modules.core.viewer.view
{
	import com.captionmashup.common.model.local.vo.Frame.Frame;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.common.view.component.CaptionCanvas.CaptionCanvas;
	import com.captionmashup.common.view.mediator.CaptionViewerMediator.AbstractCaptionViewerMediator;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.viewer.facade.ApplicationConstants;
	import com.captionmashup.modules.core.viewer.view.components.CaptionViewer.CaptionViewer;
	import com.captionmashup.modules.core.viewer.view.components.CaptionViewer.PermalinkPopup.PermalinkPopup;
	import com.captionmashup.modules.core.viewer.view.components.CaptionViewer.ViewOverlay.BottomDeck;
	import com.captionmashup.modules.core.viewer.view.components.CaptionViewer.ViewOverlay.ViewOverlay;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class ViewerMediator extends AbstractCaptionViewerMediator
	{
		public static const NAME:String = "ViewerMediator";
		private var permalinkPopup:PermalinkPopup;
		
		public function ViewerMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			permalinkPopup = new PermalinkPopup;
			permalinkPopup.initialize();
			
			permalinkPopup.addEventListener(PermalinkPopup.CLOSE,onClosePopup);
			
			bottomDeck.addEventListener(BottomDeck.SHOW_PERMALINK,onShowPermalink);
			bottomDeck.addEventListener(BottomDeck.ADD_TO_BASKET,onAddToBasket);
			bottomDeck.addEventListener(BottomDeck.CREATE_CAPTION,onCreateCaption);
			bottomDeck.dockedPanel.addEventListener(MouseEvent.ROLL_OVER,bottomDeckToggle);
			bottomDeck.frameSelector.addEventListener(MouseEvent.ROLL_OUT,bottomDeckToggle);
			
			//captionViewer.addEventListener(CaptionCanvas.DESELECT, deselect);
			captionViewer.addEventListener(ViewOverlay.CLOSE, deselect);
		}
		
		public function get captionViewer():CaptionViewer{
			return viewComponent as CaptionViewer;
		}
		
		public function get bottomDeck():BottomDeck{
			return captionViewer.overlay.bottomDeck as BottomDeck;
		}
		
		public function set authorName(value:String):void{
			bottomDeck.authorName.label = value;
		}
		
		public function set permalink(value:String):void{
			permalinkPopup.urlField.text = value;
		}
		
		/******************************
		 * Event Listeners
		 * ****************************/	
		private function bottomDeckToggle(evt:MouseEvent):void{
			if(evt.type == MouseEvent.ROLL_OVER){
				bottomDeck.frameSelector.visible = true;
			}else if(evt.type == MouseEvent.ROLL_OUT){
				bottomDeck.frameSelector.visible = false;	
			}
		}
		
		public function deselect(evt:Event):void{
			activeFrame = null;
			sendNotification(ApplicationConstants.STOP_VIEW);
		}
		
		private function onShowPermalink(evt:Event):void{
			var popupMessage:PopupMessage = new PopupMessage(PopupMessage.CREATE_POPUP,permalinkPopup);
			sendMessageToShell(popupMessage);
		}
		
		private function onClosePopup(evt:Event):void{
			var popupMessage:PopupMessage = new PopupMessage(PopupMessage.REMOVE_POPUP,permalinkPopup);
			sendMessageToShell(popupMessage);			
		}
		
		private function onAddToBasket(evt:Event):void{
			sendNotification(ApplicationConstants.ADD_TO_BASKET);
		}
		
		private function onCreateCaption(evt:Event):void{
			sendNotification(ApplicationConstants.START_CREATE);
		}
		
		private function sendMessageToShell(message:Message):void{
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,message);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.FRAME_CHANGED,
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
			switch (notification.getName())
			{	
				//Start displaying frames
				case ApplicationConstants.FRAME_CHANGED:
					//Clear captions
					captionViewer.canvas.clearCaptions();				
					activeFrame = notification.getBody() as Frame;	
					break;
			}
		}//handleNotification end
	}
}