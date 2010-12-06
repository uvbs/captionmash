package com.captionmashup.shell.controller.module.facebook
{

	import com.captionmashup.common.pipe.message.album.FacebookMessage;
	import com.captionmashup.shell.facade.ShellConstants;
	import com.captionmashup.shell.model.MessageProxy;
	import com.captionmashup.shell.view.mediator.ModuleLoaderMediator;
	import com.captionmashup.shell.view.mediator.ShellJunctionMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.AsyncCommand;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	
	/************************************************
	 * FacebookLoadedAsyncCommand
	 * 
	 * Called by LoadFacebookAsyncMacroCommand
	 * 
	 * When LoadModuleAsyncCommand loads Facebook
	 * module, this command connects the module to the
	 * shell using pipes 
	 * 
	 * Then sends the stored FacebookMessage in 
	 * MessageProxy
	 * **********************************************/	
	
	public class FacebookLoadedAsyncCommand extends AsyncCommand
	{
		private var shellJunctionMediator:ShellJunctionMediator;
		private var moduleLoaderMediator:ModuleLoaderMediator;
		private var messageProxy:MessageProxy;
		private var facebookMessage:FacebookMessage;
		
		override public function execute ( note:INotification ) : void
		{
			trace("FacebookLoadedAsyncCommand called");
			shellJunctionMediator = facade.retrieveMediator(ShellJunctionMediator.NAME) as ShellJunctionMediator;
			moduleLoaderMediator = facade.retrieveMediator(ModuleLoaderMediator.NAME) as ModuleLoaderMediator;
			
			shellJunctionMediator.connectModule(moduleLoaderMediator.facebookLoader.child as IPipeAware);
			
			facebookMessage = new FacebookMessage(FacebookMessage.GET_UI);
			
			sendNotification(ShellConstants.SEND_MESSAGE_TO_MODULE,facebookMessage);
			
			//Handle other actions about Facebook Module (loading private single img etc.)
			
			commandComplete();
		}
	}
}