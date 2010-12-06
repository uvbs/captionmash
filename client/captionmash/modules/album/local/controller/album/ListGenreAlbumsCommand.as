package com.captionmashup.modules.album.local.controller.album
{
	import com.captionmashup.common.model.local.dto.GenreDTO;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	import com.captionmashup.modules.album.local.model.AlbumProxy;
	import com.captionmashup.modules.album.local.view.BrowserMediator;
	import com.captionmashup.modules.album.local.view.PhotoBrowserMediator;
	import com.captionmashup.modules.album.local.view.components.Browser.Browser;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ListGenreAlbumsCommand extends SimpleCommand
	{
		private var albumProxy:AlbumProxy;
		private var browserMediator:BrowserMediator;
		private var photoBrowserMediator:PhotoBrowserMediator;
		
		override public function execute(notification:INotification):void
		{
			trace("ListAlbumsCommand called");
			var genreDTO:GenreDTO = notification.getBody() as GenreDTO;
			albumProxy = facade.retrieveProxy(AlbumProxy.NAME) as AlbumProxy;
			browserMediator = facade.retrieveMediator(BrowserMediator.NAME) as BrowserMediator;
			photoBrowserMediator = facade.retrieveMediator(PhotoBrowserMediator.NAME) as PhotoBrowserMediator;
			
			photoBrowserMediator.photoBrowser.tileList.dataProvider = null;
			browserMediator.browser.currentState = Browser.ALBUMS_STATE;
			
			albumProxy.getGenreAlbums(genreDTO.django_id,new AsyncResponder(resultHandler,faultHandler));
		}
		
		private function resultHandler(evt:ResultEvent,token:Object=null):void{
			t.obj(evt.result[0],"evt.result[0] in ListAlbumsCommand");
			albumProxy.setPaginator(evt.result as Array,ApplicationConstants.ALBUM_LIST_PAGE_SIZE);
		}
		
		private function faultHandler(faultEvent:FaultEvent,token:Object=null):void{
			t.obj(faultEvent.fault,"evt.fault in ListAlbumsCommand.faultHandler");
		}
	}
}