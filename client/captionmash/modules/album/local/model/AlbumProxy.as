package com.captionmashup.modules.album.local.model
{
	import com.captionmashup.common.model.gateway.MainGateway;
	import com.captionmashup.common.model.local.paginator.PaginatorEvent;
	import com.captionmashup.common.model.proxy.PaginatorProxy.AbstractPaginatorProxy;
	import com.captionmashup.common.model.proxy.delegate.AlbumProxyDelegate;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	
	
	/***********************************
	 * Proxy that stores Local Album
	 * instances 
	 * 
	 * Albums can be official or user album
	 * *********************************/
	public class AlbumProxy extends AbstractPaginatorProxy
	{
		public static const NAME:String = "AlbumProxy";
		
		private var _token:AsyncToken;
		private var _responder:AsyncResponder;
		
		public function AlbumProxy()
		{
			super(NAME);
		}
		
		//Returns official albums for a given genre id
		public function getGenreAlbums(genre_id:int,responder:AsyncResponder):void
		{
			trace("Genre django_id in AlbumProxy.getGenreAlbums: "+genre_id);
			var delegate:AlbumProxyDelegate = new AlbumProxyDelegate(responder);
			delegate.getGenreAlbums(genre_id);
		}
		
		//Returns user albums for a given user id
		public function getUserAlbums(user_id:int,responder:AsyncResponder):void{
			trace("User django_id in AlbumProxy.getUserAlbums: "+user_id);
			var delegate:AlbumProxyDelegate = new AlbumProxyDelegate(responder);
			delegate.getUserAlbums(user_id);			
		}

		override public function pageHandler(evt:PaginatorEvent):void{
			trace("pageHandler in GenreProxy");
			sendNotification(ApplicationConstants.ALBUM_PAGINATOR_NOTIFICATION,evt.data);
		}
	}
}