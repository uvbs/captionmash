package com.captionmashup.shell.controller.module.facebook
{
	import com.captionmashup.shell.controller.module.LoadModuleAsyncCommand;
	
	import org.puremvc.as3.multicore.patterns.command.AsyncMacroCommand;
	
	public class LoadFacebookAsyncMacroCommand extends AsyncMacroCommand
	{
		override protected function initializeAsyncMacroCommand () : void
		{
			trace("LoadFacebookAsyncMacroCommand called");
			
			addSubCommand(LoadModuleAsyncCommand);
			addSubCommand(FacebookLoadedAsyncCommand);
			//addSubCommand(LoadProfileAsyncCommand);
			//addSubCommand(LoadFriendsAsyncCommand);
			//addSubCommand(LoadUserAlbumsAsyncCommand);
		}
	}
}