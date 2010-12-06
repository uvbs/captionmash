package com.captionmashup.common.view.bubble
{
	import flash.geom.Point;
	
	import mx.core.Container;


	public class Caption extends Container
	{
		//Default Values
		
		private var captionX:Number = 0;
		private var captionY:Number = 0;
		private var captionHeight:Number = 100;
		private var captionWidth:Number = 200;
		private var bubbleType:uint = 0;
		private var tailEndPoint:Point = new Point(0,0);
		private var tailCurvePoint:Point = new Point(0,0);
	
	
		private var color:uint = 0xFFFFFF;
		private var outlineColor:uint = 0x000000;
		private var outlineThickness:uint = 4;
		
		
		
		public function Caption(captionVO:Object)
		{
			//TODO: implement function
			super();
			this.x = captionVO.caption_x;
			this.y = captionVO.caption_y;
			var captionBubble:Bubble = new Bubble(captionVO.caption_width,captionVO.caption_height,captionVO.bubble_type,color,outlineColor,outlineThickness);
			var bubbleTail:BubbleTail = new BubbleTail(captionVO.caption_width/2,captionVO.caption_height/2,captionVO.tail_end_point_x,captionVO.tail_end_point_y,captionVO.tail_curve_point_x,captionVO.tail_curve_point_y,captionVO.is_tail_curve,captionVO.bubble_type,color,outlineColor,outlineThickness*2);
			var bubbleText:BubbleText = new BubbleText(15,15,captionVO.caption_width-30,captionVO.caption_height-30,captionVO.text,1,captionVO.text_style,captionVO.text_size,captionVO.text_alignment,captionVO.text_font);
			
			
			if(captionVO.has_tail)
			{
				this.rawChildren.addChild(bubbleTail.getTailOutline());
			}
			
			this.rawChildren.addChild(captionBubble);
			if(captionVO.has_tail)
			{
				this.rawChildren.addChild(bubbleTail.getTailInside());
			}
			this.rawChildren.addChild(bubbleText);	
			
		}
	}
}