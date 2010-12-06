package com.captionmashup.modules.core.basket.controller.photo
{
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.basket.model.PhotoBasketProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class AddPhotoCommand extends SimpleCommand
	{
		private var photoBasketProxy:PhotoBasketProxy;
		
		override public function execute(notification:INotification):void{
			photoBasketProxy = facade.retrieveProxy(PhotoBasketProxy.NAME) as PhotoBasketProxy;
			
			if(notification.getBody() is Array){
				var source:Array = notification.getBody() as Array;
				for each(var photo:PhotoDTO in source){
				
					photoBasketProxy.addElement(photo);
				}
				return;
			}
			
			var photoDTO:PhotoDTO = notification.getBody() as PhotoDTO;
			
			t.obj(photoDTO,"photoDTO to be added to basket");
			
			photoBasketProxy.addElement(photoDTO);
		}
	}
}