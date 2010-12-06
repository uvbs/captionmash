package com.captionmashup.shell.controller.module.creator
{
	import com.captionmashup.shell.controller.module.LoadModuleAsyncCommand;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.AsyncMacroCommand;
	
	
	public class LoadCreatorAsyncMacroCommand extends AsyncMacroCommand
	{
		override protected function initializeAsyncMacroCommand () : void
		{
			trace("LoadCreatorAsyncMacroCommand called");
			addSubCommand(LoadModuleAsyncCommand);
			addSubCommand(CreatorLoadedAsyncCommand);
		}
	}
}