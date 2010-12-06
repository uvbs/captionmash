package com.captionmashup.modules.album.facebook.controller.browse
{
	import com.captionmashup.common.model.foreign.IAccount;
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.modules.album.facebook.model.proxy.AlbumProxy;
	import com.captionmashup.modules.album.facebook.fql.FqlResultUtil;
	import com.captionmashup.modules.album.facebook.view.AlbumMediator;
	import com.captionmashup.modules.album.facebook.view.PhotoMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import sk.yoz.events.FacebookOAuthGraphEvent;
	
	import com.captionmashup.common.log.t;
	
	public class LoadAlbumsCommand extends SimpleCommand
	{
		private var albumProxy:AlbumProxy;
		private var albumMediator:AlbumMediator;
		private var photoMediator:PhotoMediator;
		
		override public function execute( note:INotification ) : void
		{
			trace("LoadAlbumsCommand called");
			albumProxy = facade.retrieveProxy(AlbumProxy.NAME) as AlbumProxy;
			albumProxy.loadAlbums(note.getBody() as IAccount,onLoadAlbums);
		}
		
		//Handler
		private function onLoadAlbums(evt:FacebookOAuthGraphEvent):void
		{
			photoMediator = facade.retrieveMediator(PhotoMediator.NAME) as PhotoMediator;
			albumMediator = facade.retrieveMediator(AlbumMediator.NAME) as AlbumMediator;
			
			albumMediator.albums.visible = true;
			photoMediator.photos.visible = false;
			
			albumProxy = facade.retrieveProxy(AlbumProxy.NAME) as AlbumProxy;
			var result:Array = FqlResultUtil.albumResultToArray(evt.data);
			albumProxy.setPaginator(result,ApplicationConstants.ALBUM_PAGINATOR_PAGE_SIZE);
		}
		
	}
}