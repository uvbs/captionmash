package com.captionmashup.modules.album.facebook.model.proxy
{
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class PhotoDTOProxy extends Proxy
	{
		public static const NAME:String = "PhotoDTOProxy";
		
		public function PhotoDTOProxy()
		{
			super(NAME, new PhotoDTO);
		}
		
		public function get photoDTO():PhotoDTO{
			return this.data as PhotoDTO;
		}
	}
}