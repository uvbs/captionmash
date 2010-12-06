package com.captionmashup.modules.core.viewer.view
{
	import com.captionmashup.common.model.proxy.FrameProxy.IFrameProxy;
	import com.captionmashup.common.view.mediator.FrameSelectorMediator.AbstractFrameSelectorMediator;
	import com.captionmashup.common.view.mediator.FrameSelectorMediator.IFrameSelectorMediator;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.viewer.facade.ApplicationConstants;
	import com.captionmashup.modules.core.viewer.model.FrameProxy;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class FrameSelectorMediator extends AbstractFrameSelectorMediator implements IFrameSelectorMediator
	{
		public static const NAME:String = "FrameSelectorMediator";
		
		public function FrameSelectorMediator( viewComponent:Object=null)
		{
			super(NAME, viewComponent);	
		}
		
		override public function onRegister():void{
			frameProxy = facade.retrieveProxy(FrameProxy.NAME) as IFrameProxy;
		}			
		
		/*************************************
		 * Notification Handling
		 * **********************************/
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.FRAMES_SET,
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{	
				//Set frames
				case ApplicationConstants.FRAMES_SET:
					
					updateFrames(notification.getBody() as ArrayCollection);	
					
					play();
					
					break;
			}
		}//handleNotification end
	}
}