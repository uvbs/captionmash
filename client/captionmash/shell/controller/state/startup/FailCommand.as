package com.captionmashup.shell.controller.state.startup
{	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class FailCommand extends SimpleCommand implements ICommand
	{
		override public function execute( notification :INotification ) : void
		{
			trace("FAIL COMMAND, message: "+notification.getBody());
		}
	}
}