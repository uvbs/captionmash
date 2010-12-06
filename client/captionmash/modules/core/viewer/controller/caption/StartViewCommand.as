package com.captionmashup.modules.core.viewer.controller.caption
{
	import com.adobe.serialization.json.JSON;
	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.common.model.local.dto.CaptionDTO;
	import com.captionmashup.common.model.local.vo.Frame.Frame;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.viewer.facade.ApplicationConstants;
	import com.captionmashup.modules.core.viewer.model.FrameProxy;
	import com.captionmashup.modules.core.viewer.view.FrameSelectorMediator;
	import com.captionmashup.modules.core.viewer.view.ViewerMediator;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	
	public class StartViewCommand extends SimpleCommand
	{
		private var viewerMediator:ViewerMediator;
		private var frameSelectorMediator:FrameSelectorMediator;
		private var	frameProxy:FrameProxy;
		
		override public function execute(notification:INotification):void
		{
			frameProxy 				= facade.retrieveProxy(FrameProxy.NAME) as FrameProxy;
			viewerMediator 			= facade.retrieveMediator(ViewerMediator.NAME) as ViewerMediator;
			frameSelectorMediator	= facade.retrieveMediator(FrameSelectorMediator.NAME) as FrameSelectorMediator;
			
			var captionDTO:CaptionDTO = notification.getBody() as CaptionDTO;
			var source:ArrayCollection = createFrames(captionDTO);
			
			frameProxy.frames = source;
			viewerMediator.authorName = captionDTO.author_name;
			viewerMediator.permalink  = CommonConstants.HOMEPAGE+"/caption/?c="+captionDTO.link;
			
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL, 
				new PopupMessage(PopupMessage.CREATE_MODAL_POPUP,viewerMediator.captionViewer));
		}
		
		private function createFrames(captionDTO:CaptionDTO):ArrayCollection
		{
			var result:ArrayCollection= new ArrayCollection();
			var allFramesCaptions:Array = JSON.decode(captionDTO.caption_data);
			var tempFrame:Frame;
			
			var i:int;
			
			//For each photo in photos of caption
			for(i = 0; i < captionDTO.photos.length; i++)
			{
				tempFrame = new Frame(captionDTO.photos[i], allFramesCaptions[i]);
				result.addItem(tempFrame);
			}
			return result;
		}
	}
}