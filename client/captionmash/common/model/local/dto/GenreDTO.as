package com.captionmashup.common.model.local.dto
{
	[RemoteClass(alias="com.captionmashup.common.model.local.dto.GenreDTO")]
	[Bindable]
	public class GenreDTO
	{
		public var django_id:int = 0;
		public var thumb_path:String = "";
		public var photo_path:String = "";
		public var name:String = "";
		public var num_albums:int = 0;
		public var num_photos:int = 0;
		
	}
}