package com.captionmashup.common.model.foreign
{
	//Abstract class used for foreign network modules
	[Bindable]
	public class AbstractAlbum implements IAlbum
	{
		public var album_id:String;
		public var owner_id:String;
		public var album_name:String;
		public var album_size:int;
		
		public var cover_photo_path:String;
		public var cover_photo_thumb_path:String;

		
		public function AbstractAlbum(album_id:String,owner_id:String,name:String,size:int,cover_path:String,cover_thumb_path:String)
		{
			this.album_id = album_id;
			this.owner_id = owner_id;
			this.album_name = name;
			this.album_size = size;
			this.cover_photo_path = cover_path;
			this.cover_photo_thumb_path = cover_thumb_path;
		}
		
		public function get albumId():String{
			return album_id;
		}

	}
}