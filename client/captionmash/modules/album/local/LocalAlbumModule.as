package com.captionmashup.modules.album.local
{
	import com.captionmashup.common.pipe.PipeAwareModule;
	import com.captionmashup.modules.album.local.facade.ApplicationFacade;
	
	public class LocalAlbumModule extends PipeAwareModule
	{
		public static const NAME:String = "LocalAlbumModule";
		
		public function LocalAlbumModule()
		{
			super(ApplicationFacade.getInstance(NAME));
			ApplicationFacade(this.facade).startup(this);
		}
		
	}
}