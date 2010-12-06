package com.captionmashup.modules.core.caption_browser.controller.startup
{
	import com.captionmashup.common.view.component.SparkThumbnailTileList.SparkThumbnailTileList;
	import com.captionmashup.modules.core.caption_browser.view.CaptionBrowserJunctionMediator;
	import com.captionmashup.modules.core.caption_browser.view.CaptionBrowserMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrepCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			trace("CaptionBrowser ViewPrepCommand called");
			var captionBrowser:SparkThumbnailTileList = new SparkThumbnailTileList;
			captionBrowser.initialize();
			facade.registerMediator(new CaptionBrowserMediator(captionBrowser));
			facade.registerMediator(new CaptionBrowserJunctionMediator);

		}
	}
}