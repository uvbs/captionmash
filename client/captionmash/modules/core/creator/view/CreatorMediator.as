package com.captionmashup.modules.core.creator.view
{
	import com.captionmashup.common.model.local.vo.Frame.Frame;
	import com.captionmashup.common.pipe.message.core.BasketMessage;
	import com.captionmashup.common.pipe.message.core.NavigationMessage;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.common.view.bubble.BubblePanel;
	import com.captionmashup.common.view.component.CaptionCanvas.CaptionCanvas;
	import com.captionmashup.common.view.component.CaptionCanvas.Container.CaptionContainer;
	import com.captionmashup.common.view.mediator.CaptionViewerMediator.AbstractCaptionViewerMediator;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.creator.facade.ApplicationConstants;
	import com.captionmashup.modules.core.creator.model.CreatorFrameProxy;
	import com.captionmashup.modules.core.creator.view.components.CaptionEditor.EditOverlay;
	import com.captionmashup.modules.core.creator.view.components.CaptionEditor.Editor;
	import com.captionmashup.modules.core.creator.view.components.CaptionEditor.EditorControls.CaptionControls.CaptionControls;
	import com.captionmashup.modules.core.creator.view.components.CaptionEditor.EditorControls.EditorControls;
	import com.captionmashup.modules.core.creator.view.components.CaptionEditor.EmptyScreen.EmptyScreen;
	import com.captionmashup.modules.core.creator.view.components.CaptionEditor.ProgressPopup.ProgressPopup;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class CreatorMediator extends AbstractCaptionViewerMediator
	{
		public static const NAME:String = 'CreatorMediator';

		private var captionArray:Array;
		private var creatorFrameProxy:CreatorFrameProxy;
		private var progressPopup:ProgressPopup;
		private var activeBubbleIndex:int;
	
		public function CreatorMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			progressPopup = new ProgressPopup;
			//Creates panel objects (captionPanel etc) instead of view objects (Caption)
			editMode = true; 
			
			//Empty Screen Controls
			captionEditor.addEventListener(EmptyScreen.ADD_FROM_ALBUMS,onAddFromAlbums);
			captionEditor.addEventListener(EmptyScreen.ADD_FROM_BASKET,onShowBasket);
			captionEditor.addEventListener(EmptyScreen.UPLOAD_FILE,testFunc);
			
			//Creation Controls
			captionEditor.addEventListener(EditorControls.SUBMIT,onSubmit);
			captionEditor.addEventListener(EditorControls.CANCEL,onCancel);
			captionEditor.addEventListener(EditorControls.SHOW_BASKET,onShowBasket);
			captionEditor.addEventListener(EditorControls.PREVIEW,onPreview);
			
			//Caption Canvas Controls
			captionEditor.addEventListener(BubblePanel.SELECT_BUBBLE,onSelectBubble);
			captionEditor.addEventListener(BubblePanel.DELETE_BUBBLE,deleteListener);
			captionEditor.addEventListener(CaptionCanvas.CANVAS_CLICKED,onCanvasClicked);
			
			//Caption Controls
			captionEditor.addEventListener(CaptionControls.ADD_CAPTION,onAddCaption);
			captionEditor.addEventListener(CaptionControls.CLEAR_CAPTIONS,onClearCaptions);
			captionEditor.addEventListener(CaptionControls.CLEAR_EVERYTHING,onClearEverything);
			
			
			/*captionEditor.addEventListener(EditOverlay.CANCEL, cancelCreation);
			
			captionEditor.addEventListener(EditOverlay.ADD_CAPTION,onAddCaption);
			captionEditor.addEventListener(BubblePanel.SELECT_BUBBLE,onSelectBubble)
			captionEditor.addEventListener(CaptionCanvas.CANVAS_CLICKED,onCanvasClicked);
			captionEditor.addEventListener(EditOverlay.CLEAR_PANEL,onClearPanel);
			captionEditor.addEventListener(BubblePanel.DELETE_BUBBLE,deleteListener);
			captionEditor.addEventListener(EditOverlay.POST_CAPTIONS, postCreation);
			
			captionEditor.addEventListener(EditOverlay.PLAY,onPlay);
			captionEditor.addEventListener(EditOverlay.TOGGLE_BASKET,onToggleBasket);
			*/
		}
		
		public function get captionEditor():Editor{
			return viewComponent as Editor;
		}
		
		public function get emptyScreen():EmptyScreen{
			return captionEditor.overlay.emptyScreen as EmptyScreen;
		}
		
		override public function onRegister():void{
			creatorFrameProxy = facade.retrieveProxy(CreatorFrameProxy.NAME) as CreatorFrameProxy;
		}
		
		/*******************************
		 * Event Handlers
		 * *****************************/
		
		//Creation Controls
		private function onPreview(event:Event):void{
			sendNotification(ApplicationConstants.START_PLAY);
		}
		
		private function onShowBasket(event:Event):void{
			var basketMessage:BasketMessage = new BasketMessage(BasketMessage.TOGGLE);
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,basketMessage);
		}
		
		private function onSubmit(evt:Event):void{
			saveFrame();
			captionEditor.editorControls.enabled= false;
			sendNotification(ApplicationConstants.POST_CREATION);
		}
		
		private function onCancel(evt:Event):void{
			sendNotification(ApplicationConstants.CANCEL_CREATION);
		}
		
		//Empty Screen controls
		private function testFunc(evt:Event):void{
			trace("testFunc event: "+evt.type);
		}
		
		private function onAddFromAlbums(evt:Event):void{
			var navigationMessage:NavigationMessage = new NavigationMessage(NavigationMessage.ALBUM_HOME);
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,navigationMessage)	
		}
		//Caption Controls

		
		 /***********************************************
		 * Caption Canvas Methods
		 * ********************************************/
		private function onAddCaption(event:Event):void
		{
			var bub:BubblePanel= new BubblePanel(0);
			bub.x = 100;
			bub.y = 100+container.verticalScrollPosition;
			bub.filters = [captionContainer.shadow];
			captionContainer.addChild(bub);
			activeBubbleIndex = captionContainer.getChildIndex(bub);
			setBubbleFocus(activeBubbleIndex);
			
		}
		
		//Clear captions of current active frame
		private function onClearCaptions(event:Event):void
		{
			clearCaptions();
		}
		
		//Clear captions of current active frame
		private function onClearEverything(event:Event):void
		{
			sendNotification(ApplicationConstants.CLEAR_FRAMES);
		}
		
		private function onSelectBubble(evt:Event):void{
			activeBubbleIndex = captionContainer.getChildIndex(evt.target as BubblePanel);
			setBubbleFocus(activeBubbleIndex);
			putOnTop(activeBubbleIndex);
		}
		
		private function onCanvasClicked(event:Event):void{
			setBubbleFocus(-1);
		}
		
		/************************
		 * CAPTION SELECTION METHODS
		 * *********************/
		
		private function setBubbleFocus(index:int):void{
			for(var i:int = 0; i < captionContainer.numChildren; i++)
			{
				var bubble:BubblePanel = captionContainer.getChildAt(i) as BubblePanel;
				if(i != index){
					bubble.deactivate();				
				}else{
					bubble.activate();
				}
			}
		}
		
		public function putOnTop(index:int):void{
			var bubble:BubblePanel = captionContainer.getChildAt(index) as BubblePanel;
			captionContainer.removeChild(bubble);
			captionContainer.addChild(bubble);
		}
		

		
		private function deleteListener(event:Event):void{
			//trace("deleteListener in captionPanelMediator: "+event.target);
			captionContainer.removeChild(BubblePanel(event.target));
		}
		
		//Retrieves all children (captionPanel,propObjectPanel,filterPanel) 
		//from layers and writes into frame object 
		public function saveFrame():void{		
			creatorFrameProxy.activeFrame.captions 		= getCaptions();
			creatorFrameProxy.activeFrame.propObjects 	= getPropObjects();
			creatorFrameProxy.activeFrame.filters		= getFilters();		
			trace("frame saved");
		}
		
		public function getPropObjects():Array{
			return new Array;
		}
		
		public function getFilters():Array{
			return new Array;
		}
		
		public function getCaptions():Array{
			var captionArray:Array= new Array();
			var children:Array = captionContainer.getChildren();
			
			if(children.length == 0) return new Array;
			
			for each(var bubblePanel:BubblePanel in children){
				captionArray.push(bubblePanel);
			}
			return captionArray;
		}
		
		public function displayProgressPopup():void{
			var popupMessage:PopupMessage = new PopupMessage(PopupMessage.CREATE_MODAL_POPUP,progressPopup);
			sendMessageToShell(popupMessage);
		}
		
		public function removeProgressPopup():void{
			var popupMessage:PopupMessage = new PopupMessage(PopupMessage.REMOVE_POPUP,progressPopup);
			sendMessageToShell(popupMessage);			
		}
		
		private function sendMessageToShell(message:Message):void{
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,message)
		}

		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationConstants.FRAME_CHANGED,
					ApplicationConstants.FRAMES_EMTPY,
			];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{	
				case ApplicationConstants.FRAME_CHANGED:
					//Save current creation data (captions etc. into frame)
					setBubbleFocus(-1);
					
					clearFrame();
					activeFrame = note.getBody() as Frame;
					captionEditor.editorControls.enabled = true;
					emptyScreen.visible = false;
					removeProgressPopup();
					break;
				
				case ApplicationConstants.FRAMES_EMTPY:
					trace("Frames empty in CreatorMediator");
					clearFrame();
					activeFrame = null;
					captionEditor.editorControls.enabled = false;
					emptyScreen.visible = true;
					removeProgressPopup();
					break;
			}
		}//handleNotification end
	}
}