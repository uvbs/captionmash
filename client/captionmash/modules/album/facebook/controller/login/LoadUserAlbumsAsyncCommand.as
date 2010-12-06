package com.captionmashup.modules.album.facebook.controller.login
{
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.modules.album.facebook.model.proxy.AlbumProxy;
	import com.captionmashup.modules.album.facebook.model.proxy.UserProxy;
	import com.captionmashup.modules.album.facebook.fql.FqlResultUtil;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.AsyncCommand;
	
	import sk.yoz.events.FacebookOAuthGraphEvent;
	
	import com.captionmashup.common.log.t;
	
	public class LoadUserAlbumsAsyncCommand extends AsyncCommand
	{
		private var userProxy:UserProxy;
		private var albumProxy:AlbumProxy;
		
		override public function execute( note:INotification ) : void
		{
			trace("LoadUserAlbumsAsyncCommand called");
			userProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			albumProxy = facade.retrieveProxy(AlbumProxy.NAME) as AlbumProxy;
			albumProxy.loadAlbums(userProxy.user,onLoadUserAlbums);
		}
		
		//Handler
		private function onLoadUserAlbums(evt:FacebookOAuthGraphEvent):void
		{
			albumProxy = facade.retrieveProxy(AlbumProxy.NAME) as AlbumProxy;
			var result:Array = FqlResultUtil.albumResultToArray(evt.data);
			//t.obj(result,"LoadUserAlbumsAsyncCommand result");				
			albumProxy.setPaginator(result,ApplicationConstants.ALBUM_PAGINATOR_PAGE_SIZE);
			commandComplete();
		}
	}
}