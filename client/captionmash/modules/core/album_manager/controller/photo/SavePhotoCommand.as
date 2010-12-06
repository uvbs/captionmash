package com.captionmashup.modules.core.album_manager.controller.photo
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.album_manager.facade.ApplicationConstants;
	import com.captionmashup.modules.core.album_manager.model.PhotoProxy;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class SavePhotoCommand extends AbstractRPCCommand
	{	
		private var photoProxy:PhotoProxy;
		
		override public function execute(notification:INotification):void{
			photoProxy = facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;

			var photoDTO:PhotoDTO = notification.getBody() as PhotoDTO;
			
			photoProxy.savePhoto(photoDTO,asyncResponder);
		}
		
		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			t.obj(evt.result,"SavePhotoCommand Result");
			sendNotification(ApplicationConstants.SAVE_PHOTO_SUCCESS,evt.result);
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
			t.obj(evt.fault,"SavePhotoCommand Fault");
			sendNotification(ApplicationConstants.SAVE_PHOTO_FAIL);
		}
	}
}