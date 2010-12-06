package com.captionmashup.common.view.bubble
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.*;

	public class BubbleText extends Sprite
	{
				
		private var t:TextField = new TextField();
		private var tf:TextFormat = new TextFormat();
		private var topLeft:Point = new Point();
		private var bottomRight:Point = new Point();
		
		//DUD Variables used in Toggle Functions, normal Types are used for Database Storage
		private var dudStyleType:uint = 0;
		private var dudFontType:uint = 0;
		private var dudAlignmentType:uint = 0;   
		private var _styleType:uint = 0; //0 normal,1 bold, 2 italic, 3 italic+bold
		private var _fontType:uint = 0; // 0 Verdana 1 Impact 2 Comic Sans MS 3 Courier
		private var _alignmentType:uint = 0; // 0 Center 1 Left 2 Right
		private var fieldType:uint = 0; //0 Dynamic 1 Input
		
		private var textFieldWidth:Number = 0;
		private var textFieldHeight:Number = 0;
		
		private var textProps:Object= new Object();
		
		
		/* x, y 			=> coordinates of textfield
		 * width, height	=> size of textfield
		 * initialString	=> string that displayed at start
		 * fieldType		=> text is input or dynamic
		 *
		 */
		public function BubbleText(x:Number,y:Number,width:Number,height:Number,initialString:String,fieldType:uint,style:uint,size:uint,alignment:uint,font:uint)
		{
			super();
			
			topLeft.x = x;
			topLeft.y = y;
			
			bottomRight.x = topLeft.x + width;
			bottomRight.y = topLeft.y + height;
			
			
			this.setSize(width,height);
			
			t.x = topLeft.x;
			t.y = topLeft.y
			t.autoSize = TextFieldAutoSize.CENTER;
			t.multiline = true;
			t.wordWrap = true;
			
			 
			if(fieldType == 0){
				t.type = TextFieldType.INPUT;
			}else{
				t.type = TextFieldType.DYNAMIC;
			}
			
			this.dudAlignmentType = alignment;
			this.dudFontType = font;
			this.dudStyleType = style;
			tf.size = size;
			t.text = initialString;
			
			this.toggleAlignment();
			this.toggleStyle();
			this.toggleFont();
						
			t.setTextFormat(tf);
			
			addChild(t);
						
	
		}
		public function toggleStyle():void{
			switch(dudStyleType){
					case 0:
					dudStyleType = 1;
					_styleType = 0;
					tf.bold = false;
					tf.italic = false;		
					break;
				case 1:
					dudStyleType = 2;
					_styleType = 1;
					tf.bold = true;
					tf.italic = false;		
					break;
				case 2:
					dudStyleType = 3;
					_styleType = 2;
					tf.bold = false;
					tf.italic = true;
					break;
				case 3:
					dudStyleType = 0;
					_styleType = 3;
					tf.bold = true;
					tf.italic = true;
					break;
			}
				t.setTextFormat(tf);
		}
		
		public function toggleFont():void{
			switch(dudFontType){
				case 0:
					dudFontType = 1;
					_fontType = 0;
					tf.font = "Verdana";
					break;
				case 1:
					dudFontType = 2;
					_fontType = 1;
					tf.font = "Impact";
					break;
				case 2:
					dudFontType = 3;
					_fontType = 2;
					tf.font = "Comic Sans MS";
					break;
				case 3:
					dudFontType = 0;
					_fontType = 3;				
					tf.font = "Courier";
					break;
			}
			t.setTextFormat(tf);
		}
		
		public function changeFontSize(value:int):void{
			if(tf.size + value > 15 && tf.size + value < 130){
				tf.size = tf.size+value;
				
				t.setTextFormat(tf);	
			}
			
		}
		
		public function toggleAlignment():void{
			
			switch(dudAlignmentType){
				case 0:
					dudAlignmentType = 1;
					_alignmentType = 0;
					tf.align = "center";
					break;
				case 1:
					dudAlignmentType = 2;
					_alignmentType = 1;
					tf.align = "left";
					break;
				case 2:
					dudAlignmentType = 0;
					_alignmentType = 2;
					tf.align = "right";
					break;
			}
			t.setTextFormat(tf);
		}
		
		private function setTextFieldCoordinates(rad:Number):void{
			
			var perc:Number = (rad/1.46);
			
			t.width = perc*2;
			t.x = perc*(-1);
			t.y = t.x;
			
		}
		
		public function setSize(width:Number,height:Number):void{
		
			t.width = width;
			t.height = height;	
		}
		
		public function getTextProperties():Object{
			
			textProps.styleType = _styleType;
			textProps.fontType = _fontType;
			textProps.alignmentType = _alignmentType;
			textProps.text = t.text;
			textProps.textSize = tf.size;
			
			
			return textProps;
		}
		
		
		

			
	}
}