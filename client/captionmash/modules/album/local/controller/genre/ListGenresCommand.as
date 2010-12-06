package com.captionmashup.modules.album.local.controller.genre
{
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	import com.captionmashup.modules.album.local.model.GenreProxy;
	import com.captionmashup.modules.album.local.view.AlbumBrowserMediator;
	import com.captionmashup.modules.album.local.view.BrowserMediator;
	import com.captionmashup.modules.album.local.view.components.Browser.Browser;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ListGenresCommand extends SimpleCommand
	{
		private var genreProxy:GenreProxy;
		private var browserMediator:BrowserMediator;
		private var albumBrowserMediator:AlbumBrowserMediator;
		
		override public function execute(notification:INotification):void
		{
			trace("ListGenresCommand called");
			genreProxy = facade.retrieveProxy(GenreProxy.NAME) as GenreProxy;
			browserMediator = facade.retrieveMediator(BrowserMediator.NAME) as BrowserMediator;
			albumBrowserMediator = facade.retrieveMediator(AlbumBrowserMediator.NAME) as AlbumBrowserMediator;
			
			albumBrowserMediator.albumBrowser.tileList.dataProvider = null;
			
			browserMediator.browser.currentState = Browser.GENRES_STATE;
			
			genreProxy.getGenres(new AsyncResponder(resultHandler,faultHandler));			
		}
		
		private function resultHandler(evt:ResultEvent,token:Object=null):void{
			t.obj(evt.result[0],"evt.result[0] in ListGenresCommand");
			genreProxy.setPaginator(evt.result as Array,ApplicationConstants.GENRE_LIST_PAGE_SIZE);
		}
		
		private function faultHandler(faultEvent:FaultEvent,token:Object=null):void{
			t.obj(faultEvent.fault,"evt.fault in LatestPhotosAsyncCommand.faultHandler");
		}
	}
}