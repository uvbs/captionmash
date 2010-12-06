package com.captionmashup.modules.core.caption_browser.controller.startup
{
	import com.captionmashup.modules.core.caption_browser.controller.caption.LatestCaptionsCommand;
	
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	
	public class StartupCommand extends MacroCommand
	{
		override protected function initializeMacroCommand():void{
			trace("CaptionBrowser StartupCommand called");
			addSubCommand(ModelPrepCommand);
			addSubCommand(ViewPrepCommand);
		}
	}
}