package com.captionmashup.modules.core.album_manager.model
{
	import com.captionmashup.common.model.gateway.MainGateway;
	import com.captionmashup.common.model.local.dto.UserDTO;
	import com.captionmashup.common.model.local.paginator.PaginatorEvent;
	import com.captionmashup.common.model.proxy.PaginatorProxy.AbstractPaginatorProxy;
	import com.captionmashup.common.model.proxy.delegate.AlbumProxyDelegate;
	import com.captionmashup.modules.core.album_manager.facade.ApplicationConstants;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	
	public class AlbumProxy extends AbstractPaginatorProxy
	{
		public static const NAME:String = "AlbumProxy";
		private var token:AsyncToken;
	
		
		public function AlbumProxy(proxyName:String=null, data:Object=null)
		{
			super(NAME);
		}
		
		public function getUserAlbums(user_id:int,asyncResponder:AsyncResponder):void{
			trace("User django_id in AlbumProxy.getUserAlbums: "+user_id);
			var delegate:AlbumProxyDelegate = new AlbumProxyDelegate(asyncResponder);
			delegate.getUserAlbums(user_id);	
		}
		
		public function createAlbum(album_name:String,asyncResponder:AsyncResponder):void{
			trace("User django_id in AlbumProxy.createAlbum: "+album_name);
			var delegate:AlbumProxyDelegate = new AlbumProxyDelegate(asyncResponder);
			delegate.createAlbum(album_name);
		}
		
		public function deleteAlbum(album_id:int,asyncResponder:AsyncResponder):void{
			trace("Album django_id in AlbumProxy.deleteAlbum: "+album_id);
			var delegate:AlbumProxyDelegate = new AlbumProxyDelegate(asyncResponder);
			delegate.deleteAlbum(album_id);
		}
		
		override public function pageHandler(evt:PaginatorEvent):void{
			trace("Paginator handler in UploadModule.AlbumProxy");
			sendNotification(ApplicationConstants.ALBUM_PAGINATOR_NOTIFICATION,evt.data);
		}
	}
}