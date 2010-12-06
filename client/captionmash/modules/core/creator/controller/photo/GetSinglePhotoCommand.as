package com.captionmashup.modules.core.creator.controller.photo
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.creator.facade.ApplicationConstants;
	import com.captionmashup.modules.core.creator.model.PhotoProxy;
	import com.captionmashup.modules.core.creator.view.CreatorMediator;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class GetSinglePhotoCommand extends AbstractRPCCommand
	{
		private var photoProxy:PhotoProxy;
		private var creatorMessage:CreatorMessage;
		private var creatorMediator:CreatorMediator;
		
		override public function execute(notification:INotification):void
		{
			creatorMediator = facade.retrieveMediator(CreatorMediator.NAME) as CreatorMediator;
			photoProxy = facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;
			
			var photoLink:String = notification.getBody().toString();
			
			creatorMediator.displayProgressPopup();
			photoProxy.getPhotoByLink(photoLink,asyncResponder);
			
			trace("Creator GetSinglePhotoCommand called: "+photoLink);
		}
		
		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			t.obj(evt.result,"Result at Creator.GetSinglePhotoCommand");
			creatorMessage = new CreatorMessage(CreatorMessage.START_CREATE,evt.result);
			sendNotification( ApplicationConstants.START_CREATION,creatorMessage);	
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
			t.obj(evt.fault,"Fault at Creator.GetSinglePhotoCommand");
		}
	}
}