package com.captionmashup.modules.core.album_container.controller.startup
{
	
	import com.captionmashup.modules.core.album_container.controller.photos.ListLatestCaptionedPhotosCommand;
	
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;

	/**
	 * Startup the SimpleModule
	 */
	// A MacroCommand executed when the application starts.
	public class StartupCommand extends MacroCommand
	{
		// Initialize the MacroCommand by adding its subcommands.
		override protected function initializeMacroCommand() : void
		{
			trace("ALBUM CONTAINER MODULE STARTUP COMMAND CALLED");
			addSubCommand( ModelPrepCommand );
			addSubCommand( ViewPrepCommand );
		}
	}
}

