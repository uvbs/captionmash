package com.captionmashup.modules.core.viewer.controller.creator
{
	import com.captionmashup.common.model.local.vo.Frame.Frame;
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.modules.core.viewer.facade.ApplicationConstants;
	import com.captionmashup.modules.core.viewer.model.FrameProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**************************************
	 * Gets all photos from frame proxy
	 * Sends photos array to creator module
	 * *************************************/
	public class StartCreateCommand extends SimpleCommand
	{
		private var frameProxy:FrameProxy;
		override public function execute(notification:INotification):void{
			frameProxy = facade.retrieveProxy(FrameProxy.NAME) as FrameProxy;
			
			var source:Array = frameProxy.frames.source;
			
			
			var creatorMessage:CreatorMessage = new CreatorMessage(CreatorMessage.START_CREATE,getPhotos(source));
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,creatorMessage);
			sendNotification(ApplicationConstants.STOP_VIEW);
		}
		
		private function getPhotos(source:Array):Array{
			var result:Array = new Array;
			
			for each(var frame:Frame in source){
				result.push(frame.photo);
			}
			return result;		
		}
	}
}