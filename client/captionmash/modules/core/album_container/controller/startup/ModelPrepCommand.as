package com.captionmashup.modules.core.album_container.controller.startup
{
	import com.captionmashup.modules.core.album_container.model.PhotoProxy;
	import com.captionmashup.modules.core.album_container.model.UserProxy;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ModelPrepCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			trace("ALBUM CONTAINER MODULE MODELPREP COMMAND CALLED");
			// register proxy
			facade.registerProxy(new UserProxy);
			facade.registerProxy(new PhotoProxy);
		}
	}
}