package com.captionmashup.shell.controller.state.navigation
{
	import com.captionmashup.common.pipe.message.core.ViewerMessage;
	import com.captionmashup.shell.facade.ShellConstants;
	import com.captionmashup.shell.view.mediator.ModuleLoaderMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**********************************************
	 * Command that switches into 
	 * VIEWING state
	 * 
	 * Called by: StateMachine.ACTION,VIEW_STARTED
	 * notification body: ViewerMessage
	 * 
	 * Sends CaptionDTO object to viewer module
	 * 
	 * Normally this method would call to load 
	 * viewer module but this is an oftenly used
	 * functionality so viewer module is loaded at
	 * application start
	 * ********************************************/
	public class ViewCommand extends SimpleCommand
	{
		private var moduleLoaderMediator:ModuleLoaderMediator;
		
		override public function execute(notification:INotification):void
		{
			trace("ViewCommand command in shell called");
	
			//Passing related ModuleLoader and module URL as parameters
			moduleLoaderMediator = facade.retrieveMediator(ModuleLoaderMediator.NAME) as ModuleLoaderMediator;

			sendNotification(ShellConstants.SEND_MESSAGE_TO_MODULE,
				notification.getBody() as ViewerMessage);		
		}
	}
}