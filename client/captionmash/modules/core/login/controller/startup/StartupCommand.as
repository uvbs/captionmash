package com.captionmashup.modules.core.login.controller.startup
{
	import com.captionmashup.modules.core.login.facade.ApplicationFacade;
	
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
			trace("LOGIN STARTUP COMMAND CALLED");
			addSubCommand( ModelPrepCommand );
			addSubCommand( ViewPrepCommand );
			addSubCommand( RetrieveUserCommand);
		}
	}
}

