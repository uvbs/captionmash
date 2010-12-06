package com.captionmashup.modules.core.popup.controller.startup
{
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;

	public class StartupCommand extends MacroCommand
	{
		// Initialize the MacroCommand by adding its subcommands.
		override protected function initializeMacroCommand() : void
		{
			trace("POPUPMODULE STARTUP COMMAND CALLED");
			addSubCommand( ModelPrepCommand );
			addSubCommand( ViewPrepCommand );
		}
	}
}