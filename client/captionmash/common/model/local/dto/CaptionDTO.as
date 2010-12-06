package com.captionmashup.common.model.local.dto
{
	[RemoteClass(alias="com.captionmashup.common.model.local.dto.CaptionDTO")]
	[Bindable]
	public class CaptionDTO
	{
		//Local data
		public var django_id:int = 0;
		public var photo_django_id:int = 0;
		public var album_django_id:int = 0;
		public var author_django_id:int = 0;
		public var author_name:String = "";
		public var link:String = "";
		
		//PhotoDTO objects
		public var photos:Array 		= new Array;
		public var frame_delays:Array 	= new Array;
		
		//Serialized creation data
		public var caption_data:String;
		public var effect_data:String;
		public var object_data:String;
		public var filter_data:String;
		
		//Cover image
		public var thumb_path:String = "";
		public var photo_path:String = "";
		
		public function setCoverPhoto(thumbPath:String,photoPath:String):void{
			this.photo_path = photoPath;
			this.thumb_path = thumbPath;
		}
	}
}