package com.captionmashup.shell.controller.state.startup
{
	
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;

	// A MacroCommand executed when the application starts.
	public class StartupCommand extends MacroCommand
	{
		// Initialize the MacroCommand by adding its subcommands.
		override protected function initializeMacroCommand() : void
		{
			trace("SHELL STARTUP COMMAND CALLED");
			
			addSubCommand(InjectFSMCommand);
			addSubCommand(StartShellCommand);
			//addSubCommand( ModelPrep );
			//addSubCommand( ViewPrep );
		}
	}
}