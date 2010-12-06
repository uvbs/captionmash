package com.captionmashup.modules.core.album_manager
{
	import com.captionmashup.common.pipe.PipeAwareModule;
	import com.captionmashup.modules.core.album_manager.facade.ApplicationFacade;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	
	public class AlbumManagerModule extends PipeAwareModule
	{
		public static const NAME:String = "UploadModule";
		
		public function AlbumManagerModule()
		{
			super(ApplicationFacade.getInstance(NAME));
			ApplicationFacade(this.facade).startup(this);
		}
	}
}