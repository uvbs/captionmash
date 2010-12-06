package com.captionmashup.modules.core.creator.controller.frame
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class SwapFrameCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			trace("SwapFrameCommand called");
		}
	}
}