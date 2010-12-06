package com.captionmashup.modules.core.album_manager.controller.album
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.model.local.dto.AlbumDTO;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.album_manager.model.AlbumProxy;
	import com.captionmashup.modules.core.album_manager.model.PhotoProxy;
	import com.captionmashup.modules.core.album_manager.view.AlbumBrowserMediator;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class DeleteAlbumCommand extends AbstractRPCCommand
	{
		private var albumProxy:AlbumProxy;
		private var photoProxy:PhotoProxy;
		private var albumBrowserMediator:AlbumBrowserMediator;
		override public function execute(notification:INotification):void{
			albumProxy = facade.retrieveProxy(AlbumProxy.NAME) as AlbumProxy;
			photoProxy = facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;
			albumBrowserMediator = facade.retrieveMediator(AlbumBrowserMediator.NAME) as AlbumBrowserMediator;
			
			var album_id:int = AlbumDTO(albumBrowserMediator.albumBrowser.tileList.selectedItem).django_id;

			albumProxy.deleteAlbum(album_id,asyncResponder);
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
			t.obj(evt.fault,"Fault in CreateAlbumCommand");
		}
		
		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			albumProxy.setPaginator(evt.result as Array);
			photoProxy.setPaginator(null);
			trace("Album result in CreateAlbumCommand");
		}
	}
}