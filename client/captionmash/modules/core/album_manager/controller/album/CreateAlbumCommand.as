package com.captionmashup.modules.core.album_manager.controller.album
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.album_manager.model.AlbumProxy;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class CreateAlbumCommand extends AbstractRPCCommand
	{
		private var albumProxy:AlbumProxy;
		override public function execute(notification:INotification):void{
			albumProxy = facade.retrieveProxy(AlbumProxy.NAME) as AlbumProxy;
			
			var albumName:String = notification.getBody() as String;
			albumProxy.createAlbum(albumName,asyncResponder);
		}
		
		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			albumProxy.setPaginator(evt.result as Array);
			trace("Album result in CreateAlbumCommand");
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
			t.obj(evt.fault,"Fault in CreateAlbumCommand");
		}
		

	}
}