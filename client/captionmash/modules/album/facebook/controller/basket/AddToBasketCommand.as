package com.captionmashup.modules.album.facebook.controller.basket
{
	import com.captionmashup.common.pipe.message.core.BasketMessage;
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.modules.album.facebook.model.proxy.PhotoDTOProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class AddToBasketCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			trace("FACEBOOK AddToBasketCommand COMMAND CALLED");
			var photoDTOProxy:PhotoDTOProxy = facade.retrieveProxy(PhotoDTOProxy.NAME) as PhotoDTOProxy;
			
			var basketMessage:BasketMessage = new BasketMessage(BasketMessage.ADD_PHOTO,photoDTOProxy.photoDTO);
			
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,basketMessage);
		}
	}
}