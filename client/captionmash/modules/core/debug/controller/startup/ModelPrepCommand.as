package com.captionmashup.modules.core.debug.controller.startup
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ModelPrepCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			trace("DEBUG MODELPREP CALLED");
		}
	}
}