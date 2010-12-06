package com.captionmashup.modules.album.local.controller.album
{
	import com.captionmashup.common.model.local.dto.GenreDTO;
	import com.captionmashup.common.model.local.dto.UserDTO;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	import com.captionmashup.modules.album.local.model.AlbumProxy;
	import com.captionmashup.modules.album.local.model.UserProxy;
	import com.captionmashup.modules.album.local.view.BrowserMediator;
	import com.captionmashup.modules.album.local.view.PhotoBrowserMediator;
	import com.captionmashup.modules.album.local.view.components.Browser.Browser;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ListUserAlbumsCommand extends SimpleCommand
	{
		private var user:UserDTO;
		private var albumProxy:AlbumProxy;
		private var userProxy:UserProxy;
		private var browserMediator:BrowserMediator;
		private var photoBrowserMediator:PhotoBrowserMediator;
		
		override public function execute(notification:INotification):void
		{
			trace("ListUserAlbumsCommand called");
			albumProxy = facade.retrieveProxy(AlbumProxy.NAME) as AlbumProxy;
			userProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			browserMediator = facade.retrieveMediator(BrowserMediator.NAME) as BrowserMediator;
			photoBrowserMediator = facade.retrieveMediator(PhotoBrowserMediator.NAME) as PhotoBrowserMediator;
			
			photoBrowserMediator.photoBrowser.tileList.dataProvider = null;
			browserMediator.browser.currentState = Browser.ALBUMS_STATE;
			//Get user albums
			if(notification.getBody() == null){
				user = userProxy.user;
			}else{
				user = notification.getBody() as UserDTO;
			}
			
			albumProxy.getUserAlbums(user.django_id,new AsyncResponder(resultHandler,faultHandler));
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