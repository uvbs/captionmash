package com.captionmashup.modules.album.facebook.controller.login
{
	import org.puremvc.as3.multicore.patterns.command.AsyncMacroCommand;
	
	public class InitAsyncMacroCommand extends AsyncMacroCommand
	{
		override protected function initializeAsyncMacroCommand () : void
		{
			trace("InitAsyncMacroCommand called, body:");
			addSubCommand(LoadProfileAsyncCommand);
			addSubCommand(LoadFriendsAsyncCommand);
			addSubCommand(LoadUserAlbumsAsyncCommand);
		}
	}
}