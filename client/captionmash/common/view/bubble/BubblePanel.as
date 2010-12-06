package com.captionmashup.common.view.bubble
{
	import com.captionmashup.common.model.local.vo.CaptionVO;
	
	import flash.events.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.Container;
	import mx.events.FlexEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import com.captionmashup.common.log.t;

	public final class BubblePanel extends Container implements IFocusManagerComponent
	{
		private var rm:IResourceManager = ResourceManager.getInstance();
		
		
		private const ROUND_BUTTON_SIZE:Number = 25;
		private const RESCALE_BUTTON_SIZE:Number = 30;
		private const TAIL_BUTTON_SIZE:Number = 15;
		

		
		private var dragging:Boolean = false;
		private var tailDragging:Boolean = false;
		private var rescaling:Boolean = false;
		private var showTail:Boolean = true;

		public var isActive:Boolean = true;
		
		
		//Event Names
		public static var SELECT_BUBBLE:String = "select_bubble";
		public static var DELETE_BUBBLE:String = "delete_bubble";
		
		//Default Values
		
		private var panelHeight:Number = BubbleConstants.BUBBLE_HEIGHT;
		private var panelWidth:Number = BubbleConstants.BUBBLE_WIDTH;
		private var bubbleType:uint = 0;
	
	
		private var color:uint = 0xFFFFFF;
		private var outlineColor:uint = 0x000000;
		private var outlineThickness:uint = 4;
						
		//components
		private	var bubble:Bubble = new Bubble(panelWidth,panelHeight,bubbleType,color,outlineColor,outlineThickness);
		private var bubbleTail:BubbleTail = new BubbleTail(panelWidth*0.5,panelHeight*0.5,BubbleConstants.BUBBLE_TAIL_END_X,BubbleConstants.BUBBLE_TAIL_END_Y,0,0,false,bubbleType,color,outlineColor,outlineThickness*2);
		private var bubbleText:BubbleText = new BubbleText(15,15,180,80,rm.getString("Caption","DEFAULT_TEXT"),0,0,24,0,0);
		private var buttonContainer:ButtonContainer = new ButtonContainer();
		
				
		public function BubblePanel(bubbleType:uint)
		{
			super();
			this.buttonMode = true;	
					
			bubble.setBubbleType(bubbleType);
			bubbleTail.setTailType(bubbleType,showTail);
			
			
			this.rawChildren.addChild(bubbleTail.getTailOutline());
			this.rawChildren.addChild(bubble);
			this.rawChildren.addChild(bubbleTail.getTailInside());
			this.rawChildren.addChild(bubbleText);
			this.rawChildren.addChild(buttonContainer);
			arrangeTailButtons();
			
			this.addEventListener(PanelButtonEvent.RESCALE_DRAG,rescaleHandler);
			this.addEventListener(PanelButtonEvent.TAIL_END_DRAG,tailHandler);
			this.addEventListener(PanelButtonEvent.TAIL_CURVE_DRAG,tailHandler);
		
			this.addEventListener(PanelButtonEvent.FONT_ENLARGE,textEventHandler);
			this.addEventListener(PanelButtonEvent.FONT_SHRINK,textEventHandler);
			this.addEventListener(PanelButtonEvent.FONT_ALIGNMENT_TOGGLE,textEventHandler);
			this.addEventListener(PanelButtonEvent.FONT_STYLE_TOGGLE,textEventHandler);
			this.addEventListener(PanelButtonEvent.FONT_TYPE_TOGGLE,textEventHandler);
			
			this.addEventListener(PanelButtonEvent.BUBBLE_DELETE,deleteHandler);
			this.addEventListener(PanelButtonEvent.BUBBLE_TYPE_TOGGLE,bubbleTypeHandler);
			this.addEventListener(PanelButtonEvent.TAIL_TOGGLE,tailHandler);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
			this.addEventListener(MouseEvent.MOUSE_UP,mouseUpListener);
			bubbleText.addEventListener(MouseEvent.MOUSE_DOWN,textClickListener);

		}
		
		private function arrangeTailButtons():void{
			buttonContainer.setTailEndButtonCoordinates(bubbleTail.getTailEndPoint().x,bubbleTail.getTailEndPoint().y);
			buttonContainer.setCurveButtonCoordinates(bubbleTail.getTailCurvePoint().x,bubbleTail.getTailCurvePoint().y);
		}
		/*************************************
		 * EVENT HANDLERS
		 * *************************************/

		private function mouseDownListener(event:MouseEvent):void{
			trace("bubblePanel.mouseDownListener event target: "+ event.target);
			if(event.target is Bubble || event.target is BubbleTail){
				startDrag();
				dragging = true;	
				sendEvent(SELECT_BUBBLE);
			}
			
			isActive = true;
		}
		
		private function deleteHandler(evt:PanelButtonEvent):void{
			//trace("bubblePanel.deleteHandler event target: "+ evt.target);
			sendEvent(DELETE_BUBBLE);
		}
		
		// Sends the named event
		private function sendEvent(eventName:String):void
		{          
			trace("sending event from BubblePanel: "+eventName);
			dispatchEvent(new Event(eventName,true));
		}
		
		private function mouseUpListener(event:MouseEvent):void{
			stopDrag();
			dragging = false;	
		}

		private function textDragListener(e:Event):void{
			e.stopPropagation();
			
		}
		
		private function textClickListener(e:Event):void{
			e.stopPropagation();
					
		}
		private function rescaleHandler(evt:PanelButtonEvent):void{
					panelWidth = evt.args.getItemAt(0) as Number;
					panelHeight = evt.args.getItemAt(1) as Number;
					
					//resize textfield
					bubbleText.setSize(panelWidth-30,panelHeight-30);
	
					
					//relocate delete button
												
					bubble.setBubbleSize(panelWidth,panelHeight);
					
					var center:Point = new Point(panelWidth/2,panelHeight/2);
					
					//update tail
					if(showTail){
						bubbleTail.setTail(center);
						buttonContainer.setTailEndButtonCoordinates(bubbleTail.getTailEndPoint().x,bubbleTail.getTailEndPoint().y);
						buttonContainer.setCurveButtonCoordinates(bubbleTail.getTailCurvePoint().x,bubbleTail.getTailCurvePoint().y);
							
					}
		}

		
		private function bubbleTypeHandler(evt:PanelButtonEvent):void{
			bubble.toggleBubbleType();
			this.bubbleType = bubble.getBubbleType();
			this.bubbleTail.setTailType(bubbleType,showTail);
		}
		
		private function tailHandler(evt:PanelButtonEvent):void{
			
			switch(evt.type)
			 {	                
	            case  PanelButtonEvent.TAIL_TOGGLE:
	            		if(showTail){
							bubbleTail.clearTail();
							showTail = false;

						}else{
							var p:Point = new Point(panelWidth/2,panelHeight/2);
							bubbleTail.setTail(p);
							arrangeTailButtons();
							showTail = true;
							bubbleTail.draw();
						}
					break;
						
				case PanelButtonEvent.TAIL_END_DRAG:
						var t:Point = new Point(evt.args.getItemAt(0)as Number,evt.args.getItemAt(1) as Number);
						bubbleTail.setTailEndPoint(t);
						bubbleTail.draw();
						
						buttonContainer.setCurveButtonCoordinates(bubbleTail.getTailCurvePoint().x,bubbleTail.getTailCurvePoint().y);
											
	            	break;
	            	
	            case PanelButtonEvent.TAIL_CURVE_DRAG:
	            
	            		var p1:Point = new Point(evt.args.getItemAt(0) as Number,evt.args.getItemAt(1) as Number);
				
						bubbleTail.setTailCurvePoint(p1);
						bubbleTail.drawCurve();
		            
	        }
		}
		
		private function textEventHandler(evt:PanelButtonEvent):void{
			switch(evt.type)
			 {	                
	            case  PanelButtonEvent.FONT_ENLARGE:
	            		bubbleText.changeFontSize(1);
	            	break;
	            
			   case  PanelButtonEvent.FONT_SHRINK:
	            		bubbleText.changeFontSize(-1);
	            	break;
	            	
	            case  PanelButtonEvent.FONT_TYPE_TOGGLE:
	            		bubbleText.toggleFont();
	            	break;
	            	
	            case  PanelButtonEvent.FONT_STYLE_TOGGLE:
	            		bubbleText.toggleStyle();
	            	break;
	            	
	            case  PanelButtonEvent.FONT_ALIGNMENT_TOGGLE:
	            		bubbleText.toggleAlignment();
	            	break;

	            		            
	        }
		}
		

		
		/*************************************
		 * VALIDITY CHECK
		 * ***********************************/
		public function get isValid():Boolean{
			if(this.x > 0 && this.y > 0 && this.x < this.parent.width && y < this.parent.height){
				return true;
			} else{
				return false;
			}
		}

		/**************************************
		 * activate disactivate panel controls
		 * *************************************/
		public function activate():void{
			this.isActive = true;
			this.buttonContainer.visible = true;
		}
		
		public function deactivate():void{
			this.isActive = false;
			this.buttonContainer.visible = false;
		}

		

		
		/*****************************************
		 * RETURN FUNCTIONS FOR PANEL AND CHILDREN'S PROPERTIES
		 * getTextProperties:Array ===> BubbleText
		 * 									   			styleType,fontType,alignmentType,text,textSize
		 * getBubbleType:uint =========>Bubble
		 * 
		 * BubblePanel===========> showTail,  caption_x, caption_y, caption_height,caption_width,bubble_type,caption_depth,
		*														has_tail,tail_end_point_x,tail_end_point_y,tail_curve_point_x,tail_curve_point_y,
		* *****************************************/
		 
		 //All panel properties except depth and caption_set_id
		 public function getCaptionVO():CaptionVO{
		 	
		 	var captionVO:CaptionVO = new CaptionVO();
		 	
		 	//captionVO.caption_set_id = 0;
			captionVO.text_style = this.bubbleText.getTextProperties().styleType;
			captionVO.text_font  = this.bubbleText.getTextProperties().fontType;
			captionVO.text_alignment = this.bubbleText.getTextProperties().alignmentType;
			captionVO.text = this.bubbleText.getTextProperties().text;
			captionVO.text_size = this.bubbleText.getTextProperties().textSize;
			captionVO.bubble_type  = this.bubbleType;
			captionVO.has_tail  = this.showTail;
			captionVO.tail_end_point_x = this.bubbleTail.getTailEndPoint().x;
			captionVO.tail_end_point_y = this.bubbleTail.getTailEndPoint().y;
			captionVO.tail_curve_point_x  = this.bubbleTail.getTailCurvePoint().x;
			captionVO.tail_curve_point_y = this.bubbleTail.getTailCurvePoint().y;
			captionVO.caption_x = this.x;
			captionVO.caption_y = this.y;
			captionVO.caption_width = this.panelWidth;
			captionVO.caption_height = this.panelHeight;
			captionVO.is_tail_curve = this.bubbleTail.getIsCurve();
		 	
			captionVO.color = this.color;
			captionVO.outline_color = this.outlineColor;
			
		 	return captionVO;
		 }
		 
		 
		
	}
}