package com.captionmashup.modules.album.facebook.controller.basket
{
	import com.captionmashup.modules.album.facebook.controller.common.CreatePhotoDTOCommand;
	
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	
	public class AddToBasketMacroCommand extends MacroCommand
	{
		override protected function initializeMacroCommand() : void
		{
			trace("FACEBOOK AddToBasketMacroCommand COMMAND CALLED");
			addSubCommand( CreatePhotoDTOCommand );
			addSubCommand( AddToBasketCommand);
		}
	}
}