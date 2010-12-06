package com.captionmashup.modules.core.album_container
{
	import com.captionmashup.common.pipe.PipeAwareModule;
	import com.captionmashup.modules.core.album_container.facade.ApplicationFacade;
	
	public class AlbumContainerModule extends PipeAwareModule
	{
		public static const NAME:String = "AlbumContainerModule";
		
		public function AlbumContainerModule()
		{
			super(ApplicationFacade.getInstance(NAME));
			ApplicationFacade(this.facade).startup(this);
		}
		
	}
}