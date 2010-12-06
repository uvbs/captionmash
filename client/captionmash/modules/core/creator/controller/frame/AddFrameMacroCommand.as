package com.captionmashup.modules.core.creator.controller.frame
{
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	
	public class AddFrameMacroCommand extends MacroCommand
	{
		override protected function initializeMacroCommand():void
		{
			trace("AddFrameMacroCommand called");
			addSubCommand(SaveFrameCommand);
			addSubCommand(AddFrameCommand);
		}
	}
}