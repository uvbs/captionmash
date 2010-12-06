package com.captionmashup.modules.core.album_manager.controller.startup
{
	import com.captionmashup.modules.core.album_manager.controller.album.ListUserAlbumsCommand;
	
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;

	public class StartupCommand extends MacroCommand
	{
		// Initialize the MacroCommand by adding its subcommands.
		override protected function initializeMacroCommand() : void
		{
			trace("UPLOADMODULE STARTUP COMMAND CALLED");
			addSubCommand( ModelPrepCommand );
			addSubCommand( ViewPrepCommand );
		}
	}
}