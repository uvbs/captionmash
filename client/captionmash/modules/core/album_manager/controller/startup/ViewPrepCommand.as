package com.captionmashup.modules.core.album_manager.controller.startup
{

	import com.captionmashup.modules.core.album_manager.view.AlbumBrowserMediator;
	import com.captionmashup.modules.core.album_manager.view.PhotoBrowserMediator;
	import com.captionmashup.modules.core.album_manager.view.AlbumManagerJunctionMediator;
	import com.captionmashup.modules.core.album_manager.view.AlbumManagerMediator;
	import com.captionmashup.modules.core.album_manager.view.components.AlbumManager.AlbumManagerPopup;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("UPLOADMODULE VIEWPREP COMMAND CALLED");
			var uploadPopup:AlbumManagerPopup = new AlbumManagerPopup();
			uploadPopup.initialize();
			
			facade.registerMediator(new AlbumManagerMediator(uploadPopup));
			facade.registerMediator(new AlbumBrowserMediator(uploadPopup.albumBrowser));
			facade.registerMediator(new PhotoBrowserMediator(uploadPopup.photoBrowser));
			facade.registerMediator(new AlbumManagerJunctionMediator());
		}
	}
}