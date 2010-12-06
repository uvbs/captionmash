package com.captionmashup.modules.album.facebook.controller.creator
{
	import com.captionmashup.modules.album.facebook.controller.common.CreatePhotoDTOCommand;
	
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	
	public class StartCreateMacroCommand extends MacroCommand
	{
		override protected function initializeMacroCommand() : void
		{
			trace("FACEBOOK StartCreateMacroCommand COMMAND CALLED");
			addSubCommand( CreatePhotoDTOCommand );
			addSubCommand( StartCreateCommand);
		}
	}
}