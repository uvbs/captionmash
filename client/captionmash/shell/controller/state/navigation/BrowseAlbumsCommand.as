package com.captionmashup.shell.controller.state.navigation
{
	import com.captionmashup.shell.view.mediator.AppScreenMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class BrowseAlbumsCommand extends SimpleCommand
	{
		private var appScreenMediator:AppScreenMediator;
		
		override public function execute(notification:INotification):void
		{
			trace("BrowseAlbumsCommand command in shell called");
			appScreenMediator = facade.retrieveMediator(AppScreenMediator.NAME) as AppScreenMediator;
			
			appScreenMediator.appScreen.viewStack.selectedIndex = 1;
			
		}
	}
}