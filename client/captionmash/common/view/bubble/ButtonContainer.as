package com.captionmashup.common.view.bubble
{
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.events.FlexEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	
	public final class ButtonContainer extends Canvas{
		
		
		private var rm:IResourceManager = ResourceManager.getInstance();
		private var args:ArrayCollection;
		
		//uses rescaleButton coordinate system
		private const RESCALE_BOUNDS:Rectangle= new Rectangle(100,50,500,500);
		
		private const ROUND_BUTTON_SIZE:Number = 25;
		private const RESCALE_BUTTON_SIZE:Number = 30;
		private const TAIL_BUTTON_SIZE:Number = 15;

		private var rescaling:Boolean = false;
		private var tailDragging:Boolean = false;
		private var showTail:Boolean = true;
	
		private var bubbleChangeButton:PanelButton = new PanelButton("B",ROUND_BUTTON_SIZE,rm.getString("Caption","Tooltip.CHANGE_BUBBLE_TYPE"),false,BubbleConstants.PANEL_BUBBLE_BUTTON_STYLE);
		private var tailToggleButton:PanelButton = new PanelButton("T",ROUND_BUTTON_SIZE,rm.getString("Caption","Tooltip.TOGGLE_TAIL"),false,BubbleConstants.PANEL_BUBBLE_BUTTON_STYLE);
		private var rescaleButton:PanelButton = new PanelButton("R", RESCALE_BUTTON_SIZE,rm.getString("Caption","Tooltip.RESIZE_BUBBLE"),false,BubbleConstants.PANEL_BUBBLE_BUTTON_STYLE);
		
		private var fontEnlargeButton:PanelButton = new PanelButton("+",ROUND_BUTTON_SIZE,rm.getString("Caption","Tooltip.FONT_ENLARGE"),true,BubbleConstants.PANEL_FONT_BUTTON_STYLE);
		private var fontShrinkButton:PanelButton = new PanelButton("-",ROUND_BUTTON_SIZE,rm.getString("Caption","Tooltip.FONT_SHRINK"),true,BubbleConstants.PANEL_FONT_BUTTON_STYLE);
		private var alignButton:PanelButton = new PanelButton("A",ROUND_BUTTON_SIZE,rm.getString("Caption","Tooltip.FONT_ALIGN"),false,BubbleConstants.PANEL_FONT_BUTTON_STYLE);
		private var fontToggleButton:PanelButton = new PanelButton("F",ROUND_BUTTON_SIZE,rm.getString("Caption","Tooltip.FONT_TYPE"),false,BubbleConstants.PANEL_FONT_BUTTON_STYLE);
		private var boldToggleButton:PanelButton = new PanelButton("S",ROUND_BUTTON_SIZE,rm.getString("Caption","Tooltip.FONT_STYLE"),false,BubbleConstants.PANEL_FONT_BUTTON_STYLE);
		
		private var deleteButton:PanelButton = new PanelButton("X",ROUND_BUTTON_SIZE,rm.getString("Caption","Tooltip.DELETE"),false,BubbleConstants.PANEL_DELETE_BUTTON_STYLE);
		
		
		private var tailEndButton:PanelButton = new PanelButton("",TAIL_BUTTON_SIZE,rm.getString("Caption","Tooltip.TAIL_END"),false,BubbleConstants.PANEL_TAIL_BUTTON_STYLE);
		private var tailCurveButton:PanelButton = new PanelButton("",TAIL_BUTTON_SIZE,rm.getString("Caption","Tooltip.TAIL_CURVE"),false,BubbleConstants.PANEL_TAIL_BUTTON_STYLE);
		
	
			 
		private var buttonEvent:PanelButtonEvent;
		
		public function ButtonContainer()
		{
			super();
		
			this.width = BubbleConstants.BUBBLE_WIDTH;
			this.height = BubbleConstants.BUBBLE_HEIGHT;
			
					
			addButton(rescaleButton,this.width,this.height);
			addButton(fontEnlargeButton,-ROUND_BUTTON_SIZE,-ROUND_BUTTON_SIZE);
			addButton(fontShrinkButton,fontEnlargeButton.x+ROUND_BUTTON_SIZE,-ROUND_BUTTON_SIZE);
			addButton(alignButton,fontShrinkButton.x+ROUND_BUTTON_SIZE,-ROUND_BUTTON_SIZE);
			addButton(fontToggleButton,alignButton.x+ROUND_BUTTON_SIZE,-ROUND_BUTTON_SIZE);
			addButton(boldToggleButton,fontToggleButton.x+ROUND_BUTTON_SIZE,-ROUND_BUTTON_SIZE);
			addButton(deleteButton,this.width,-ROUND_BUTTON_SIZE);
			
			addButton(bubbleChangeButton,-ROUND_BUTTON_SIZE,30);
			addButton(tailToggleButton,-ROUND_BUTTON_SIZE,bubbleChangeButton.y+ROUND_BUTTON_SIZE);
			
			addButton(tailEndButton,BubbleConstants.BUBBLE_TAIL_END_X,BubbleConstants.BUBBLE_TAIL_END_Y);
			addButton(tailCurveButton,0,0);
			
			
			
			bubbleChangeButton.addEventListener(MouseEvent.CLICK,bubbleTypeListener);
			tailToggleButton.addEventListener(MouseEvent.CLICK,tailToggleListener);
			
			rescaleButton.addEventListener(MouseEvent.MOUSE_DOWN,rescaleStartListener);
			rescaleButton.addEventListener(MouseEvent.MOUSE_UP,rescaleStopListener);
			rescaleButton.addEventListener(MouseEvent.MOUSE_MOVE,rescaleDragListener);
			rescaleButton.addEventListener(MouseEvent.CLICK,stopClick);
					
			fontEnlargeButton.addEventListener(FlexEvent.BUTTON_DOWN, fontEnlargeListener);
			fontEnlargeButton.addEventListener(MouseEvent.CLICK,stopClick);
			
			fontShrinkButton.addEventListener(FlexEvent.BUTTON_DOWN, fontShrinkListener);
			fontShrinkButton.addEventListener(MouseEvent.CLICK,stopClick);
			
			
			alignButton.addEventListener(MouseEvent.CLICK, fontAlignListener);
			fontToggleButton.addEventListener(MouseEvent.CLICK,fontToggleListener);
			boldToggleButton.addEventListener(MouseEvent.CLICK,fontStyleListener);
			
			deleteButton.addEventListener(MouseEvent.CLICK, deleteListener);
				
			tailEndButton.addEventListener(MouseEvent.MOUSE_DOWN,tailEndDragStartListener);
			tailEndButton.addEventListener(MouseEvent.MOUSE_UP,tailEndDragStopListener);
			tailEndButton.addEventListener(MouseEvent.MOUSE_MOVE,tailEndDragListener);
			tailEndButton.addEventListener(MouseEvent.CLICK,stopClick);
			
		 	tailCurveButton.addEventListener(MouseEvent.MOUSE_DOWN,tailCurveDragStartListener);
			tailCurveButton.addEventListener(MouseEvent.MOUSE_UP,tailCurveDragStopListener);
			tailCurveButton.addEventListener(MouseEvent.MOUSE_MOVE,tailCurveDragListener);
			tailCurveButton.addEventListener(MouseEvent.CLICK,stopClick);
				
		}
		
		//this function is used to stop click event from bubbling for bubble deselection
		private function stopClick(evt:MouseEvent):void{
			evt.stopPropagation();
		}
		
		private function addButton(button:PanelButton,buttonX:Number,buttonY:Number):void{
			this.rawChildren.addChild(button);
			button.x = buttonX;
			button.y = buttonY;
		}
		
		private function rescaleStartListener(evt:MouseEvent):void{
			rescaling = true;
			evt.stopPropagation();
		}
		
		private function rescaleDragListener(evt:MouseEvent):void{
			if(rescaling){
				
				this.deleteButton.x = rescaleButton.x;
				
				args = new ArrayCollection();
				args.addItem(rescaleButton.x);
				args.addItem(rescaleButton.y);
				this.rescaleButton.startDrag(false,RESCALE_BOUNDS);
				
				dispatchEvent(new PanelButtonEvent(PanelButtonEvent.RESCALE_DRAG,true,false,args));
				evt.updateAfterEvent();
			}
		}
		
		private function rescaleStopListener(evt:MouseEvent):void{
			evt.stopPropagation();
			rescaling = false;
			this.rescaleButton.stopDrag();
		}
		
		private function fontAlignListener(evt:MouseEvent):void{
			evt.stopPropagation();
			dispatchEvent(new PanelButtonEvent(PanelButtonEvent.FONT_ALIGNMENT_TOGGLE,true,false));
		}
		
		private function fontToggleListener(evt:MouseEvent):void{
			evt.stopPropagation();
			dispatchEvent(new PanelButtonEvent(PanelButtonEvent.FONT_TYPE_TOGGLE,true,false));
		}
		
		private function fontStyleListener(evt:MouseEvent):void{
			evt.stopPropagation();
			dispatchEvent(new PanelButtonEvent(PanelButtonEvent.FONT_STYLE_TOGGLE,true,false));
		}
		
		private function deleteListener(evt:MouseEvent):void{
			evt.stopPropagation();
			dispatchEvent(new PanelButtonEvent(PanelButtonEvent.BUBBLE_DELETE,true,false));
		}
		
		private function fontEnlargeListener(evt:FlexEvent):void{
			evt.stopPropagation();
			dispatchEvent(new PanelButtonEvent(PanelButtonEvent.FONT_ENLARGE,true,false));
		}
		
		private function fontShrinkListener(evt:FlexEvent):void{
			evt.stopPropagation();
			dispatchEvent(new PanelButtonEvent(PanelButtonEvent.FONT_SHRINK,true,false));
		}
		
		private function bubbleTypeListener(evt:MouseEvent):void{
			evt.stopPropagation();
			dispatchEvent(new PanelButtonEvent(PanelButtonEvent.BUBBLE_TYPE_TOGGLE,true,false));
		}
		
		private function tailToggleListener(evt:MouseEvent):void{
			evt.stopPropagation();
			if(showTail)
			{
				this.rawChildren.removeChild(tailEndButton);
				this.rawChildren.removeChild(tailCurveButton);	
				showTail = false;
			}else{
				this.rawChildren.addChild(tailEndButton);
				this.rawChildren.addChild(tailCurveButton);
				showTail = true;
			}
			dispatchEvent(new PanelButtonEvent(PanelButtonEvent.TAIL_TOGGLE,true,false));
		}
		
		private function tailEndDragStartListener(evt:MouseEvent):void{
			evt.stopPropagation();
			tailDragging = true;
		}
		
		private function tailEndDragStopListener(evt:MouseEvent):void{
			tailEndButton.stopDrag();
			tailDragging = false;
		}
		
		private function tailEndDragListener(evt:MouseEvent):void{
				if(tailDragging){
					args = new ArrayCollection();
					args.addItem(tailEndButton.x);
					args.addItem(tailEndButton.y);
					tailEndButton.startDrag(false);
					
					dispatchEvent(new PanelButtonEvent(PanelButtonEvent.TAIL_END_DRAG,true,false,args));
					evt.updateAfterEvent();	
				}
						
		}
		
		private function tailCurveDragStartListener(evt:MouseEvent):void{
			evt.stopPropagation();
			tailDragging = true;
		}
		
		private function tailCurveDragStopListener(evt:MouseEvent):void{
			tailCurveButton.stopDrag();
			tailDragging = false;
		}
		
		private function tailCurveDragListener(evt:MouseEvent):void{
				if(tailDragging){
					args = new ArrayCollection();
					args.addItem(tailCurveButton.x);
					args.addItem(tailCurveButton.y);
					tailCurveButton.startDrag(false);
					
					dispatchEvent(new PanelButtonEvent(PanelButtonEvent.TAIL_CURVE_DRAG,true,false,args));
					evt.updateAfterEvent();	
				}
						
		}
		
		public function setCurveButtonCoordinates(x:Number,y:Number):void{
			tailCurveButton.x = x;
			tailCurveButton.y = y;

		}
		
		public function setTailEndButtonCoordinates(x:Number,y:Number):void{
			tailEndButton.x = x;
			tailEndButton.y = y;

		}
		

		
	}
}