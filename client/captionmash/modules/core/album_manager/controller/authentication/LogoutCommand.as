package com.captionmashup.modules.core.album_manager.controller.authentication
{
	import com.captionmashup.modules.core.album_manager.model.AlbumProxy;
	import com.captionmashup.modules.core.album_manager.model.PhotoProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class LogoutCommand extends SimpleCommand
	{
		private var photoProxy:PhotoProxy;
		private var albumProxy:AlbumProxy;
		
		override public function execute(notification:INotification):void{
			photoProxy = facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;
			albumProxy = facade.retrieveProxy(AlbumProxy.NAME) as AlbumProxy;
			
			photoProxy.setPaginator(null);
			albumProxy.setPaginator(null);
		}
	}
}