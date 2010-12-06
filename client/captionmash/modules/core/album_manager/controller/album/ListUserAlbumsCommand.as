package com.captionmashup.modules.core.album_manager.controller.album
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.album_manager.facade.ApplicationConstants;
	import com.captionmashup.modules.core.album_manager.model.AlbumProxy;
	import com.captionmashup.modules.core.album_manager.model.UserProxy;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ListUserAlbumsCommand extends AbstractRPCCommand
	{
		private var albumProxy:AlbumProxy;
		private var userProxy:UserProxy;
		
		override public function execute(notification:INotification):void{
			albumProxy = facade.retrieveProxy(AlbumProxy.NAME) as AlbumProxy;
			userProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			
			var user_id:int = userProxy.user.django_id;
			trace("User.django_id in ListAlbumsCommand: "+user_id);
			albumProxy.getUserAlbums(user_id,asyncResponder);
		}
		
		override protected function onResult(evt:ResultEvent,token:Object=null):void{
			t.obj(evt.result,"evt.result at UploadModule.ListUserAlbumsCommand");
			albumProxy.setPaginator(evt.result as Array,ApplicationConstants.ALBUM_PAGINATOR_PAGE_SIZE);
		}
		
		override protected function onFault(evt:FaultEvent,token:Object=null):void{
			t.obj(evt.fault,"evt.fault at UploadModule.ListUserAlbumsCommand");
		}
	}
}