package com.captionmashup.modules.core.creator.controller.startup
{

	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.creator.model.CreatorFrameProxy;
	import com.captionmashup.modules.core.creator.model.CreatorProxy;
	import com.captionmashup.modules.core.creator.model.PhotoProxy;
	import com.captionmashup.modules.core.creator.model.UserProxy;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ModelPrepCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			trace("CREATOR MODELPREP COMMAND CALLED");
			// register proxy
			facade.registerProxy(new CreatorProxy());
			facade.registerProxy(new CreatorFrameProxy());
			facade.registerProxy(new UserProxy());
			facade.registerProxy(new PhotoProxy());

		}
	}
}