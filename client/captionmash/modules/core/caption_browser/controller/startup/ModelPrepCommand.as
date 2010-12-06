package com.captionmashup.modules.core.caption_browser.controller.startup
{
	import com.captionmashup.modules.core.caption_browser.model.CaptionProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ModelPrepCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			trace("CaptionBrowser ModelPrepCommand called");
			facade.registerProxy(new CaptionProxy);
		}
	}
}