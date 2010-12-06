package com.captionmashup.modules.core.caption_browser.controller.caption
{

	import com.captionmashup.modules.core.caption_browser.model.CaptionProxy;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.caption_browser.facade.ApplicationConstants;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**************************************
	 * LatestCaptionsCommand
	 * Notifications:
	 * LATEST_CAPTIONS
	 * 
	 * Calls for latest captions 
	 * **********************************/
	public class LatestCaptionsCommand extends SimpleCommand
	{
		private var captionProxy:CaptionProxy;
		
		override public function execute(notification:INotification):void
		{
			trace("LatestCaptionsAsyncCommand called");
			
			captionProxy = facade.retrieveProxy(CaptionProxy.NAME) as CaptionProxy;

			captionProxy.getLatestCaptions(new AsyncResponder(resultHandler,faultHandler));
			
		}
		
		private function resultHandler(evt:ResultEvent,token:Object=null):void{
			//t.obj(evt.result,"result in LatestCaptionsCommand");
			captionProxy.setPaginator(evt.result as Array,ApplicationConstants.CAPTION_LIST_PAGE_SIZE);
		}
		
		private function faultHandler(faultEvent:FaultEvent,token:Object=null):void{
			t.obj(faultEvent.fault,"evt.fault in LatestCaptionsCommand.faultHandler");
		}
	}
}