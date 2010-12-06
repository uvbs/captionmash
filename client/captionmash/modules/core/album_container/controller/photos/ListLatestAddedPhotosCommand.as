package com.captionmashup.modules.core.album_container.controller.photos
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.album_container.facade.ApplicationConstants;
	import com.captionmashup.modules.core.album_container.model.PhotoProxy;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class ListLatestAddedPhotosCommand extends AbstractRPCCommand
	{
		private var photoProxy:PhotoProxy;
		override public function execute(notification:INotification):void{
			photoProxy = facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;
			
			photoProxy.getLatestAddedPhotos(asyncResponder);
		}
		
		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			photoProxy.setPaginator(evt.result as Array, ApplicationConstants.PHOTO_LIST_PAGE_SIZE);	
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
		 	t.obj(evt.fault,"Fault at ListLatestAddedPhotosCommand");
		}
	}
}