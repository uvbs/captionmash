package com.captionmashup.modules.core.viewer.controller.caption
{
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.common.pipe.message.core.ViewerMessage;
	import com.captionmashup.modules.core.viewer.facade.ApplicationConstants;
	import com.captionmashup.modules.core.viewer.view.FrameSelectorMediator;
	import com.captionmashup.modules.core.viewer.view.ViewerMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StopViewCommand extends SimpleCommand
	{
		private var frameSelectorMediator:FrameSelectorMediator;
		private var viewerMediator:ViewerMediator;
		override public function execute(notification:INotification):void{
			frameSelectorMediator 	= facade.retrieveMediator(FrameSelectorMediator.NAME) as FrameSelectorMediator;
			viewerMediator 			= facade.retrieveMediator(ViewerMediator.NAME) as ViewerMediator;

			viewerMediator.clearFrame();
			frameSelectorMediator.stop();
			
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL, 
				new ViewerMessage(ViewerMessage.END_VIEW));
			
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL, 
				new PopupMessage(PopupMessage.REMOVE_POPUP,viewerMediator.captionViewer));
		}
	}
}