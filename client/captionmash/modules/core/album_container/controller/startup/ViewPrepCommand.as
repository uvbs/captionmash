package com.captionmashup.modules.core.album_container.controller.startup
{

	import com.captionmashup.modules.core.album_container.view.AlbumContainerJunctionMediator;
	import com.captionmashup.modules.core.album_container.view.AlbumMenuMediator;
	import com.captionmashup.modules.core.album_container.view.PhotoBrowserMediator;
	import com.captionmashup.modules.core.album_container.view.components.AlbumMenu.AlbumMenu;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("ALBUM CONTAINER MODULE VIEWPREP COMMAND CALLED");
			var albumMenu:AlbumMenu = new AlbumMenu();
			albumMenu.menuHome.initialize();
			
			facade.registerMediator(new AlbumContainerJunctionMediator());
			facade.registerMediator(new AlbumMenuMediator(albumMenu));
			facade.registerMediator(new PhotoBrowserMediator(albumMenu.menuHome.photos));

		}
	}
}