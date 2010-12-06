package com.captionmashup.modules.album.local.controller.startup
{
	import com.captionmashup.common.view.component.SparkThumbnailTileList.SparkThumbnailTileList;
	import com.captionmashup.modules.album.local.view.AlbumBrowserMediator;
	import com.captionmashup.modules.album.local.view.BrowserMediator;
	import com.captionmashup.modules.album.local.view.GenreBrowserMediator;
	import com.captionmashup.modules.album.local.view.LocalBrowserJunctionMediator;
	import com.captionmashup.modules.album.local.view.MemberBrowserMediator;
	import com.captionmashup.modules.album.local.view.PhotoBrowserMediator;
	import com.captionmashup.modules.album.local.view.components.Browser.Browser;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrepCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			trace("LOCAL ALBUM MODULE ViewPrepCommand called");
			var browser:Browser = new Browser();
			browser.initialize();
			
			facade.registerMediator(new BrowserMediator(browser));
			facade.registerMediator(new GenreBrowserMediator(browser.genres));
			facade.registerMediator(new AlbumBrowserMediator(browser.albums));
			facade.registerMediator(new PhotoBrowserMediator(browser.photos));
			facade.registerMediator(new MemberBrowserMediator(browser.members));
			facade.registerMediator(new LocalBrowserJunctionMediator());
		}
	}
}