package com.captionmashup.modules.core.album_container.controller.ui.local_album
{
	import com.captionmashup.modules.core.album_container.view.AlbumMenuMediator;
	
	import mx.core.IVisualElement;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class SetLocalAlbumUICommand extends SimpleCommand
	{
		private var albumMenuMediator:AlbumMenuMediator;
		
		override public function execute(notification:INotification):void{
			albumMenuMediator = facade.retrieveMediator(AlbumMenuMediator.NAME) as AlbumMenuMediator;
			
			if(albumMenuMediator.albumMenu.localAlbumBrowserContainer.numElements != 0) return;
			
			albumMenuMediator.albumMenu.localAlbumBrowserContainer.addElement(notification.getBody() as IVisualElement)
		}
	}
}