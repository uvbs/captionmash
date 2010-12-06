package com.captionmashup.common.model.local.vo.Frame
{
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	
	import flash.display.BitmapData;

	[Bindable]
	public class Frame
	{
		public var captions:Array;
		public var propObjects:Array;
		public var filters:Array;
		public var bitmapData:BitmapData;
		public var photo:PhotoDTO
		public var delay:int;
		
		public function Frame(photo:PhotoDTO,
							  captions:Array	= null,
							  propObjects:Array	= null,
							  filters:Array		= null,
							  delay:int 		= 3)
		{
			this.photo = photo;
			this.captions 		= captions == null 		? new Array : captions;	
			this.propObjects 	= propObjects == null 	? new Array : propObjects;
			this.filters 		= filters == null 		? new Array : filters;
			this.delay			= delay;
			
		}
	}
}