package com.captionmashup.common.view.bubble
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class PanelButtonEvent extends Event
	{
		public var args:ArrayCollection;
		

		public static const RESCALE_DRAG:String = "rescale_drag";
		public static const BUBBLE_CHANGE:String = "bubble_change";
		public static const FONT_ENLARGE:String = "font_enlarge";
		public static const FONT_SHRINK:String = "font_shrink";
		public static const FONT_TYPE_TOGGLE:String = "font_type_toggle";
		public static const FONT_ALIGNMENT_TOGGLE:String = "font_alignment_toggle";
		public static const FONT_STYLE_TOGGLE:String = "font_style_toggle";
		public static const BUBBLE_TYPE_TOGGLE:String = "bubble_type_toggle";
		public static const BUBBLE_DELETE:String = "bubble_delete";
		public static const TAIL_TOGGLE:String = "tail_toggle";
		public static const TAIL_END_DRAG:String = "tail_end_drag";
		public static const TAIL_CURVE_DRAG:String = "tail_curve_drag";

		
		public function PanelButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,args:ArrayCollection=null)
		{
			super(type, bubbles, cancelable);
			this.args = args;
		}
		
		
		
	}
}