package com.captionmashup.modules.album.facebook.model.dto
{
	import com.captionmashup.common.model.foreign.AbstractPhoto;
	[Bindable]
	public class Photo extends AbstractPhoto
	{
		public var object_id:String;
		public var caption:String;
		
		public function Photo(id:String,path:String,thumb_path:String,object_id:String,caption:String)
		{
			super(id,path,thumb_path);
			this.object_id = object_id;
			this.caption = caption;
		}
	}
}