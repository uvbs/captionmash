package com.captionmashup.modules.core.basket.controller.startup
{
	import com.captionmashup.modules.core.basket.model.PhotoBasketProxy;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ModelPrepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("BASKETMODULE MODELPREP COMMAND CALLED");
			facade.registerProxy(new PhotoBasketProxy());
			
		}
	}
}