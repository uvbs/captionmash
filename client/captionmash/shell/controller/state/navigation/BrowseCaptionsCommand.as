package com.captionmashup.shell.controller.state.navigation
{
	import com.captionmashup.common.pipe.message.core.CaptionBrowserMessage;
	import com.captionmashup.shell.facade.ShellConstants;
	import com.captionmashup.shell.facade.ShellFacade;
	import com.captionmashup.shell.view.mediator.AppScreenMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class BrowseCaptionsCommand extends SimpleCommand
	{
		private var appScreenMediator:AppScreenMediator;
		private var captionBrowserMessage:CaptionBrowserMessage;
		
		override public function execute(notification:INotification):void
		{
			trace("BrowseCaptionsCommand command in shell called");
			appScreenMediator = facade.retrieveMediator(AppScreenMediator.NAME) as AppScreenMediator;
			
			appScreenMediator.appScreen.viewStack.selectedIndex = 0;
			
			if(ShellFacade.is_browser_default_refresh){
				trace("sending CaptionBrowserMessage.LATEST_CAPTIONS from BrowseCaptionsCommand");
				captionBrowserMessage = new CaptionBrowserMessage(CaptionBrowserMessage.LATEST_CAPTIONS);
				sendNotification(ShellConstants.SEND_MESSAGE_TO_MODULE,captionBrowserMessage);
			}
		}
	}
}