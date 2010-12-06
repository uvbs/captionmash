package com.captionmashup.modules.album.facebook.controller.browse
{
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.modules.album.facebook.model.dto.Album;
	import com.captionmashup.modules.album.facebook.model.proxy.PhotoProxy;
	import com.captionmashup.modules.album.facebook.fql.FqlResultUtil;
	import com.captionmashup.modules.album.facebook.view.AlbumMediator;
	import com.captionmashup.modules.album.facebook.view.PhotoMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import sk.yoz.events.FacebookOAuthGraphEvent;
	
	import com.captionmashup.common.log.t;
	
	public class LoadPhotosCommand extends SimpleCommand
	{
		private var photoProxy:PhotoProxy;
		private var albumMediator:AlbumMediator;
		private var photoMediator:PhotoMediator;
		
		override public function execute( note:INotification ) : void
		{
			trace("LoadPhotosCommand called");
			photoProxy = facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;
			photoProxy.loadPhotos(note.getBody() as Album,onLoadPhotos);
		}
		
		//Handler
		private function onLoadPhotos(evt:FacebookOAuthGraphEvent):void
		{
			photoMediator = facade.retrieveMediator(PhotoMediator.NAME) as PhotoMediator;
			albumMediator = facade.retrieveMediator(AlbumMediator.NAME) as AlbumMediator;
				
			albumMediator.albums.visible = false;
			photoMediator.photos.visible = true;
			
			photoProxy = facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;
			var result:Array = FqlResultUtil.photoResultToArray(evt.data);
			photoProxy.setPaginator(result,ApplicationConstants.PHOTO_PAGINATOR_PAGE_SIZE);
		}
	}
}