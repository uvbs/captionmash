package com.captionmashup.common.view.mediator.CaptionViewerMediator
{
	import com.captionmashup.common.model.local.vo.Frame.Frame;
	import com.captionmashup.common.view.bubble.BubblePanel;
	import com.captionmashup.common.view.bubble.Caption;
	import com.captionmashup.common.view.component.CaptionCanvas.Container.BitmapContainer;
	import com.captionmashup.common.view.component.CaptionCanvas.Container.CaptionContainer;
	import com.captionmashup.common.log.t;
	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import spark.components.Group;
	import spark.components.VScrollBar;
	
	public class AbstractCaptionViewerMediator extends Mediator implements ICaptionViewerMediator
	{
		protected var isEditor:Boolean;
		
		public function AbstractCaptionViewerMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			//TODO: implement function
			super(mediatorName, viewComponent);
			viewComponent.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
		}
		
		public function get container():Group{
			return viewComponent.canvas.container as Group;
		}

		public function set activeFrame(frame:Frame):void
		{
			if(frame == null){
				imageData 	= null;
				captions 	= null;
				propObjects = null;
				return;
			}
			imageData 	= frame.bitmapData;
			captions	= frame.captions;
			propObjects = frame.propObjects;	
		}
		
		public function clearFrame():void{
			clearCaptions();
			clearFilters();
			clearPropObjects();
		}
		
		public function set imageData(bitmapData:BitmapData):void
		{
			//bitmapContainer.imageData = bitmapData;
			viewComponent.canvas.imageData = bitmapData;
		}
		
		public function set captions(source:Array):void
		{
			if(isEditor){
				createCaptionPanels(source);
			} else {
				createCaptions(source);
			}
		}
		
		public function clearCaptions():void{
			trace("clearing captions in abstractCaptionViewerMediator");
			captionContainer.clearCanvas();
		}
		
		public function set propObjects(source:Array):void
		{
			//TODO: implement function
		}
		
		public function clearPropObjects():void{
			
		}
		
		public function set filters(filters:Array):void
		{
			//TODO: implement function
		}
		
		public function clearFilters():void{
			
		}
		
		public function set editMode(value:Boolean):void{
			isEditor = value;
		}
		
		public function get captionContainer():CaptionContainer
		{
			return viewComponent.canvas.captionContainer as CaptionContainer;
		}
		
		public function get bitmapContainer():BitmapContainer
		{
			return viewComponent.canvas.bitmapContainer as BitmapContainer;
		}
		
		private function createCaptions(source:Array):void{
			for each (var captionObject:Object in source)
			{
				var caption:Caption= new Caption(captionObject);
				caption.filters = [captionContainer.shadow];
				captionContainer.addChild(caption);
			}
		}
		
		private function createCaptionPanels(source:Array):void{
			for each(var captionPanel:BubblePanel in source){
				captionContainer.addChild(captionPanel);
			}
		}
		
		protected function onMouseWheel(evt:MouseEvent):void{
			container.verticalScrollPosition -= evt.delta * 30;
		}
	}
}