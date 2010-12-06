package com.captionmashup.common.model.local.dto
{
	import flash.utils.ByteArray;

	[RemoteClass(alias="com.captionmashup.common.model.local.dto.PhotoDTO")]
	[Bindable]
	public class PhotoDTO
	{	
		//Local Data (Django)
		public var django_id:int = 0;
		public var network_django_id:int = 0;
		public var photo_is_public:Boolean = false;
		
		
		//Foreign Data
		public var photo_id:String = "";
		public var album_id:String = "";
		public var owner_id:String = "";
		public var network_name:String = "";
		
		//Photo properties
		public var thumb_path:String = "";
		public var photo_path:String = "";
		public var page_no:int;
		public var source_url:String = "";
		public var title:String = "";
		public var file_size:int;
		public var link:String;
		
	}
}