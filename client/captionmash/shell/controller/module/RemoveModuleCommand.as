package com.captionmashup.shell.controller.module
{
	import com.captionmashup.shell.facade.ShellConstants;
	import com.captionmashup.shell.view.mediator.AppScreenMediator;
	
	import mx.modules.ModuleLoader;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class RemoveModuleCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("RemoveModuleCommand called, notification.getName()"+notification.getName());
			switch(notification.getName())
			{
				case ShellConstants.REMOVE_CREATOR:
					trace("RemoveModuleCommand => Removing creator");
					var appScreenMediator:AppScreenMediator = facade.retrieveMediator(AppScreenMediator.NAME) as AppScreenMediator;
					removeModule(appScreenMediator.appScreen.creatorLoader);
					//loadModule(appScreenMediator.appScreen.creatorLoader,ShellConstants.CREATOR_MODULE_URL);
					break;
			}
			
		}
		
		private function removeModule(moduleLoader:ModuleLoader):void{
			moduleLoader.unloadModule();
			moduleLoader.visible = false;
		}
	}
}