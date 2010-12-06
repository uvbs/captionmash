package com.captionmashup.modules.core.debug.controller.startup
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	
	public class StartupCommand extends MacroCommand
	{
		// Initialize the MacroCommand by adding its subcommands.
		override protected function initializeMacroCommand() : void
		{
			trace("DEBUG STARTUP COMMAND CALLED");
			addSubCommand( ModelPrepCommand );
			addSubCommand( ViewPrepCommand );
		}
	}
}