package com.captionmashup.modules.core.viewer.controller.caption
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.model.local.dto.CaptionDTO;
	import com.captionmashup.common.pipe.message.core.ViewerMessage;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.viewer.facade.ApplicationConstants;
	import com.captionmashup.modules.core.viewer.model.CaptionProxy;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class GetCaptionCommand extends AbstractRPCCommand
	{
		private var captionProxy:CaptionProxy;
		override public function execute(notification:INotification):void{
			
			captionProxy = facade.retrieveProxy(CaptionProxy.NAME) as CaptionProxy;
			captionProxy.getCaptionByLink(String(notification.getBody()),asyncResponder);
			captionProxy.caption = null;
		 	trace("GetCaptionCommand called");
			
		}
		
		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			if(evt.result == null){
				sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL, 
					new ViewerMessage(ViewerMessage.END_VIEW));
			}else{
				captionProxy.caption = evt.result as CaptionDTO;
				sendNotification(ApplicationConstants.START_VIEW,captionProxy.caption);	
			}
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
			t.obj(evt.fault,"fault in GetCaptionCommand");
		}
	}
}