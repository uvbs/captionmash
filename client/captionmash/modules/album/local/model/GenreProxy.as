package com.captionmashup.modules.album.local.model
{
	import com.captionmashup.common.model.gateway.MainGateway;
	import com.captionmashup.common.model.local.paginator.PaginatorEvent;
	import com.captionmashup.common.model.proxy.PaginatorProxy.AbstractPaginatorProxy;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	
	
	/*********************************
	 * Proxy that lookups Genres
	 * by name 
	 * *******************************/
	public class GenreProxy extends AbstractPaginatorProxy
	{
		public static const NAME:String = "GenreProxy";
		
		private var _token:AsyncToken;
		private var _responder:AsyncResponder;
		
		public function GenreProxy()
		{
			super(NAME);
		}
		
		public function getGenres(responder:AsyncResponder):void{
			//MainGateway.getAlbumService()
			_token = MainGateway.getAlbumService().getGenres();
			_token.type = "getGenres"
			_token.addResponder(responder);
		}
		
		override public function pageHandler(evt:PaginatorEvent):void{
			trace("pageHandler in GenreProxy");
			sendNotification(ApplicationConstants.GENRE_PAGINATOR_NOTIFICATION,evt.data);
		}
		
	}
}