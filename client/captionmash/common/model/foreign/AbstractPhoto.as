package com.captionmashup.common.model.foreign
{
	//Abstract class used for foreign network modules
	[Bindable]
	public class AbstractPhoto
	{
		public var photo_id:String;
		public var photo_path:String;
		public var thumb_path:String;

		public function AbstractPhoto(id:String,photo_path:String,thumb_path:String)
		{
			photo_id = id;
			this.photo_path = photo_path;
			this.thumb_path = thumb_path;
		}
	}
}