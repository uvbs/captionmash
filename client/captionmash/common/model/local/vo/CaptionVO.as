package com.captionmashup.common.model.local.vo
{
//Basic value object to create a speech bubble or caption instance	

	[Bindable]
	public class CaptionVO
	{
		
			public var text_style:uint;
			public var text_font:uint;
			public var text_alignment:uint;
			public var text:String;
			public var text_size:int;
			public var bubble_type:uint;
			public var has_tail:Boolean;
			public var tail_end_point_x:Number;
			public var tail_end_point_y:Number;
			public var tail_curve_point_x:Number;
			public var tail_curve_point_y:Number;
			public var caption_x:Number;
			public var caption_y:Number;
			public var caption_width:Number;
			public var caption_height:Number;
			public var is_tail_curve:Boolean;
			public var color:uint;
			public var outline_color:uint;
			
			public function CaptionVO(obj:Object = null){
				
				if (obj == null) return;
				
				this.text_style = obj.text_style
				this.text_font = obj.text_font;
				this.text_alignment = obj.text_alignment;
				this.text = obj.text;
				this.text_size = obj.text_size;
				this.bubble_type = obj.bubble_type;
				this.has_tail = obj.has_tail;
				this.tail_end_point_x = obj.tail_end_point_x;
				this.tail_end_point_y = obj.tail_end_point_y;
				this.tail_curve_point_x = obj.tail_curve_point_x;
				this.tail_curve_point_y = obj.tail_curve_point_y;
				this.caption_x = obj.caption_x;
				this.caption_y = obj.caption_y; 
				this.caption_width = obj.caption_width;
				this.caption_height = obj.caption_height;
				this.is_tail_curve = obj.is_tail_curve;
		
				this.color = obj.color;
				this.outline_color = obj.outline_color;
			}
			        
	        public function get isValid():Boolean
	        {
	            return text !="" && text != null;
	        }		

	}
}