package com.captionmashup.common.model.proxy.delegate
{
	import com.captionmashup.common.model.gateway.MainGateway;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;

	public class AlbumProxyDelegate
	{
		private var _token:AsyncToken;
		private var _responder:AsyncResponder;
		
		public function AlbumProxyDelegate(responder:AsyncResponder)
		{
			_responder = responder;	
		}
		
		public function getGenreAlbums(genre_id:int):void{
			_token = MainGateway.getAlbumService().getGenreAlbums(genre_id);
			_token.type = "getAlbums"
			_token.addResponder(_responder);	
		}
		
		public function getUserAlbums(user_id:int):void{
			_token = MainGateway.getAlbumService().getUserAlbums(user_id);
			_token.type = "getAlbums"
			_token.addResponder(_responder);	
		}
		
		public function createAlbum(album_name:String):void{
			_token = MainGateway.getAlbumService().createAlbum(album_name);
			_token.type = "getAlbums"
			_token.addResponder(_responder);
		}
		
		public function deleteAlbum(album_id:int):void{
			_token = MainGateway.getAlbumService().deleteAlbum(album_id);
			_token.type = "getAlbums"
			_token.addResponder(_responder);
		}
	}
}