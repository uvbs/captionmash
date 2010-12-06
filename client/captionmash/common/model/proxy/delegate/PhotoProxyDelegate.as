package com.captionmashup.common.model.proxy.delegate
{
	import com.captionmashup.common.model.gateway.MainGateway;
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	
	public class PhotoProxyDelegate
	{
		private var _token:AsyncToken;
		private var _responder:AsyncResponder;
		
		public function PhotoProxyDelegate(responder:AsyncResponder)
		{
			_responder = responder;	
		}
		
		public function getPhotoByLink(photo_link:String):void{
			_token = MainGateway.getAlbumService().getPhotoByLink(photo_link);
			_token.type = "getPhotos"
			_token.addResponder(_responder);	
		}
		
		public function getAlbumPhotos(album_id:int):void{
			_token = MainGateway.getAlbumService().getAlbumPhotos(album_id);
			_token.type = "getPhotos"
			_token.addResponder(_responder);	
		}
		
		public function savePhoto(photoDTO:PhotoDTO):void{
			_token = MainGateway.getAlbumService().savePhoto(photoDTO);
			_token.type = "savePhoto"
			_token.addResponder(_responder);
		}
		
		public function deletePhoto(photo_id:int):void{
			_token = MainGateway.getAlbumService().deletePhoto(photo_id);
			_token.type = "deletePhoto"
			_token.addResponder(_responder);			
		}
		
		public function getLatestCaptionedPhotos():void{
			_token = MainGateway.getAlbumService().getLatestCaptionedPhotos();
			_token.type = "getPhotos"
			_token.addResponder(_responder);			
		}
		
		public function getLatestAddedPhotos():void{
			_token = MainGateway.getAlbumService().getLatestAddedPhotos();
			_token.type = "getPhotos"
			_token.addResponder(_responder);			
		}
		
		
		
		
	}
}