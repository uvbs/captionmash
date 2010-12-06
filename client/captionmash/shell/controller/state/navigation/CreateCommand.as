package com.captionmashup.shell.controller.state.navigation
{
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.shell.facade.ShellConstants;
	import com.captionmashup.shell.model.MessageProxy;
	import com.captionmashup.shell.view.mediator.AppScreenMediator;
	import com.captionmashup.shell.view.mediator.ModuleLoaderMediator;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	/**********************************************
	 * Command that switches into 
	 * CREATING state
	 * 
	 * Called by: StateMachine.ACTION,CREATE_STARTED
	 * notification body: CreatorMessage
	 * 
	 * Stores CreatorMessage in MessagesProxy
	 * Starts loading procedure for Creator Module
	 * ********************************************/
	public class CreateCommand extends SimpleCommand implements ICommand
	{
		private var moduleLoaderMediator:ModuleLoaderMediator;
		private var appScreenMediator:AppScreenMediator;
		private var messageProxy:MessageProxy;
		
		override public function execute(notification:INotification):void
		{
			trace("CreateCommand command in shell called");
			moduleLoaderMediator = facade.retrieveMediator(ModuleLoaderMediator.NAME) as ModuleLoaderMediator;
			appScreenMediator = facade.retrieveMediator(AppScreenMediator.NAME) as AppScreenMediator;
			
			appScreenMediator.appScreen.viewStack.selectedIndex = 2;
			
			if(moduleLoaderMediator.creatorLoader.child != null){
				sendNotification(ShellConstants.SEND_MESSAGE_TO_MODULE,notification.getBody());
				return;
			}
			
			//Store Message Here
			messageProxy = facade.retrieveProxy(MessageProxy.NAME) as MessageProxy;
			messageProxy.addMessage(notification.getBody() as CreatorMessage);
			
			//Load Creator Module
			//Passing related ModuleLoader and module URL as parameters
			
			//moduleLoaderMediator.creatorLoader.visible = true;
			
			//Sends notification to load Creator Module
			sendNotification(ShellConstants.LOAD_CREATOR,
							moduleLoaderMediator.creatorLoader,
							ShellConstants.CREATOR_MODULE_URL);
		}
	}
}