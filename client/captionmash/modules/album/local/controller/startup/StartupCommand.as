package com.captionmashup.modules.album.local.controller.startup
{
	import com.captionmashup.modules.album.local.controller.genre.ListGenresCommand;
	
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	
	public class StartupCommand extends MacroCommand
	{
		// Initialize the MacroCommand by adding its subcommands.
		override protected function initializeMacroCommand() : void
		{
			trace("LOCAL ALBUM MODULE STARTUP COMMAND CALLED");
			addSubCommand(ModelPrepCommand);
			addSubCommand(ViewPrepCommand);
		}
	}
}