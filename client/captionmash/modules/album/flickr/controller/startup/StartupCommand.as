
package com.captionmashup.modules.album.flickr.controller.startup
{
	import com.captionmashup.modules.album.flickr.facade.ApplicationFacade;
	
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
			trace("FLICKR STARTUP COMMAND CALLED");
			addSubCommand( ModelPrep );
			addSubCommand( ViewPrep );
		}
	}
}

