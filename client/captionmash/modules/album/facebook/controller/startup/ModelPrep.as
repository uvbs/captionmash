package com.captionmashup.modules.album.facebook.controller.startup
{
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.album.facebook.model.proxy.AlbumProxy;
	import com.captionmashup.modules.album.facebook.model.proxy.FriendProxy;
	import com.captionmashup.modules.album.facebook.model.proxy.PhotoDTOProxy;
	import com.captionmashup.modules.album.facebook.model.proxy.PhotoProxy;
	import com.captionmashup.modules.album.facebook.model.proxy.UserProxy;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ModelPrep extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("FACEBOOK MODELPREP COMMAND CALLED");
			// register proxy
			facade.registerProxy(new UserProxy);
			facade.registerProxy(new FriendProxy);
			facade.registerProxy(new PhotoProxy);
			facade.registerProxy(new AlbumProxy);
			facade.registerProxy(new PhotoDTOProxy);

		}
	}
}