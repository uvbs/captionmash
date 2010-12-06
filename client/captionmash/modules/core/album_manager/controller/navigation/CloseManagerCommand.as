package com.captionmashup.modules.core.album_manager.controller.navigation
{
	import com.captionmashup.modules.core.album_manager.model.AlbumProxy;
	import com.captionmashup.modules.core.album_manager.model.PhotoProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class CloseManagerCommand extends SimpleCommand
	{
		private var albumProxy:AlbumProxy;
		private var photoProxy:PhotoProxy;
		
		override public function execute(notification:INotification):void{
			albumProxy = facade.retrieveProxy(AlbumProxy.NAME) as AlbumProxy;
			photoProxy = facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;
			
			albumProxy.setPaginator(new Array);
			photoProxy.setPaginator(new Array);
		}
	}
}