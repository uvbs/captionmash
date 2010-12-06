package com.captionmashup.modules.core.viewer.model
{
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import com.captionmashup.common.model.proxy.FrameProxy.AbstractFrameProxy;
	import com.captionmashup.common.model.proxy.FrameProxy.IFrameProxy;
	import com.captionmashup.modules.core.viewer.facade.ApplicationConstants;
	
	import mx.collections.ArrayCollection;
	
	public class FrameProxy extends AbstractFrameProxy implements IFrameProxy
	{
		public static const NAME:String = "FrameProxy";
		
		public function FrameProxy()
		{
			super(NAME);	
		}
		
		override public function sendActiveFrame():void{
			sendNotification(ApplicationConstants.FRAME_CHANGED, frames.getItemAt(activeIndex));
		}
		
		override public function sendFrames():void{
			sendNotification(ApplicationConstants.FRAMES_SET, frames);
		}
		
		override protected function onProgress(evt:BulkProgressEvent):void{
			trace("Items: "+evt.itemsLoaded+" / "+evt.itemsTotal);
			trace("Percent : "+evt.percentLoaded+" / 100");
		}
	}
}