
package com.captionmashup.modules.core.creator.controller.startup
{
	import com.captionmashup.modules.core.creator.facade.ApplicationFacade;
	
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	
	/**
	 * Startup the SimpleModule
	 */
	// A MacroCommand executed when the application starts.
	public class StartupCommand extends org.puremvc.as3.multicore.patterns.command.MacroCommand
	{
		// Initialize the MacroCommand by adding its subcommands.
		override protected function initializeMacroCommand() : void
		{
			trace("CREATOR STARTUP COMMAND CALLED");
			addSubCommand( ModelPrepCommand );
			addSubCommand( ViewPrepCommand );
		}
	}
}

