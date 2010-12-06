package com.captionmashup.shell.controller.module.creator
{
	import com.captionmashup.common.pipe.PipeAwareModuleConstants;
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.common.pipe.message.core.LoginMessage;
	import com.captionmashup.common.log.t;
	import com.captionmashup.shell.facade.ShellConstants;
	import com.captionmashup.shell.model.MessageProxy;
	import com.captionmashup.shell.view.mediator.ModuleLoaderMediator;
	import com.captionmashup.shell.view.mediator.ShellJunctionMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.AsyncCommand;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;

	/************************************************
	 * CreatorLoadedAsyncCommand
	 * 
	 * Called by LoadCreatorAsyncMacroCommand
	 * 
	 * When LoadModuleAsyncCommand loads Creator
	 * module, this command connects the module to the
	 * shell using pipes 
	 * 
	 * Then sends the stored CreatorMessage in
	 * MessageProxy to CreatorModule
	 * **********************************************/	
	
	public class CreatorLoadedAsyncCommand extends AsyncCommand
	{
		private var shellJunctionMediator:ShellJunctionMediator;
		private var moduleLoaderMediator:ModuleLoaderMediator;
		private var messageProxy:MessageProxy;
		
		override public function execute ( note:INotification ) : void
		{
			trace("CreatorLoadedAsyncCommand called");
			shellJunctionMediator = facade.retrieveMediator(ShellJunctionMediator.NAME) as ShellJunctionMediator;
			moduleLoaderMediator = facade.retrieveMediator(ModuleLoaderMediator.NAME) as ModuleLoaderMediator;

			var creator:IPipeAware = moduleLoaderMediator.creatorLoader.child as IPipeAware;
			shellJunctionMediator.connectModule(creator);	

			//Send stored latest CreatorMessage to Creator module
			messageProxy = facade.retrieveProxy(MessageProxy.NAME) as MessageProxy;
			
			var loginMessage:LoginMessage = new LoginMessage(LoginMessage.GET_USER_DATA);
			var creatorMessage:CreatorMessage = new CreatorMessage(CreatorMessage.GET_UI);
			
			//Retrieve user object for creator module
			sendNotification(ShellConstants.SEND_MESSAGE_TO_MODULE, loginMessage);
			
			//Get creator UI
			sendNotification(ShellConstants.SEND_MESSAGE_TO_MODULE,creatorMessage);
			
			sendNotification(ShellConstants.SEND_MESSAGE_TO_MODULE,
							messageProxy.getLatestMessage(CreatorMessage));
			
			//Finish MacroCommand
			commandComplete();
		}
	}
}