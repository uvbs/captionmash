package com.captionmashup.modules.core.album_container.controller.ui.facebook
{
	import com.captionmashup.modules.core.album_container.view.AlbumMenuMediator;
	
	import mx.core.IVisualElement;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class SetFacebookUICommand extends SimpleCommand
	{
		private var albumMenuMediator:AlbumMenuMediator;
	
		override public function execute(notification:INotification):void{
			trace("AlbumContainerModule SetFacebookUICommand called");
			albumMenuMediator = facade.retrieveMediator(AlbumMenuMediator.NAME) as AlbumMenuMediator;
			
			if(albumMenuMediator.albumMenu.facebookContainer.numElements != 0) return;
			
			albumMenuMediator.albumMenu.facebookContainer.addElement(notification.getBody() as IVisualElement);
		}
	}
}