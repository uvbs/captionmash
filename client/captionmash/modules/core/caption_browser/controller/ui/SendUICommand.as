package com.captionmashup.modules.core.caption_browser.controller.ui
{
	import com.captionmashup.common.pipe.message.core.CaptionBrowserMessage;
	import com.captionmashup.modules.core.caption_browser.facade.ApplicationConstants;
	import com.captionmashup.modules.core.caption_browser.view.CaptionBrowserMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class SendUICommand extends SimpleCommand
	{
		private var captionBrowserMessage:CaptionBrowserMessage;
		private var captionBrowserMediator:CaptionBrowserMediator;
		
		override public function execute(notification:INotification):void{
			
			captionBrowserMediator = facade.retrieveMediator(CaptionBrowserMediator.NAME) as CaptionBrowserMediator;
			
			captionBrowserMessage = new CaptionBrowserMessage(CaptionBrowserMessage.SET_UI,
												captionBrowserMediator.captionBrowser);
			
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,captionBrowserMessage);
		}
	}
}