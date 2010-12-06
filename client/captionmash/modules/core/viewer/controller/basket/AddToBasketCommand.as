package com.captionmashup.modules.core.viewer.controller.basket
{
	import com.captionmashup.common.pipe.message.core.BasketMessage;
	import com.captionmashup.modules.core.viewer.facade.ApplicationConstants;
	import com.captionmashup.modules.core.viewer.model.FrameProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/*************************
	 * No notification body
	 * Photo is retrieved from
	 * FrameProxy activeFrame
	 * *************************/
	public class AddToBasketCommand extends SimpleCommand
	{
		private var frameProxy:FrameProxy;
		
		override public function execute(notification:INotification):void{
			frameProxy = facade.retrieveProxy(FrameProxy.NAME) as FrameProxy;
			
			var basketMessage:BasketMessage  = new BasketMessage(BasketMessage.ADD_PHOTO,
												frameProxy.activeFrame.photo);
			
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,basketMessage);
		}
	}
}