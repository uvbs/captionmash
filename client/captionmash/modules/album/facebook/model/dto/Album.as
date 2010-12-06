package com.captionmashup.modules.album.facebook.model.dto
{
	import com.captionmashup.common.model.foreign.AbstractAlbum;

	public class Album extends AbstractAlbum
	{
		public function Album(album_id:String,owner_id:String,
							  name:String,size:int,
							  cover_path:String,cover_thumb_path:String)
		{
			super(album_id,owner_id,name,size,cover_path,cover_thumb_path);
		}

	}
}