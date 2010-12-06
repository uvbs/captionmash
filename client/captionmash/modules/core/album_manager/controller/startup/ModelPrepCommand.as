package com.captionmashup.modules.core.album_manager.controller.startup
{
	import com.captionmashup.modules.core.album_manager.model.AlbumProxy;
	import com.captionmashup.modules.core.album_manager.model.PhotoProxy;
	import com.captionmashup.modules.core.album_manager.model.UserProxy;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ModelPrepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("UPLOADMODULE MODELPREP COMMAND CALLED");

			facade.registerProxy(new UserProxy);
			facade.registerProxy(new AlbumProxy);
			facade.registerProxy(new PhotoProxy);
		}
	}
}