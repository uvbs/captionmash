package com.captionmashup.modules.core.album_manager.controller.photo
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.model.local.dto.AlbumDTO;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.album_manager.facade.ApplicationConstants;
	import com.captionmashup.modules.core.album_manager.model.PhotoProxy;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class ListAlbumPhotosCommand extends AbstractRPCCommand
	{
		private var photoProxy:PhotoProxy;
		
		override public function execute(notification:INotification):void{
			photoProxy = facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;
			
			var albumDTO:AlbumDTO = notification.getBody() as AlbumDTO;
			photoProxy.getAlbumPhotos(albumDTO.django_id,asyncResponder);
		}
		
		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			t.obj(evt.result,"result in uploadmodule list album photos command");
			photoProxy.setPaginator(evt.result as Array,
									ApplicationConstants.PHOTO_PAGINATOR_PAGE_SIZE,
									"page_no",true);
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
			t.obj(evt.fault,"fault in uploadmodule list album photos command");
			trace("Fault at UploadModule.ListAlbumPhotosCommand");	
		}
	}
}