package com.captionmashup.shell.controller.state.startup
{
	import com.captionmashup.shell.facade.ShellConstants;
	import com.captionmashup.shell.model.MessageProxy;
	import com.captionmashup.shell.view.mediator.AppScreenMediator;
	import com.captionmashup.shell.view.mediator.ModuleLoaderMediator;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.utilities.statemachine.StateMachine;
	
	public class StartShellCommand extends SimpleCommand implements ICommand
	{
		override public function execute( notification :INotification ) : void
		{
			trace("STARTSHELL COMMAND CALLED");
			
			
			try
			{
				var shell:caption_mashup_multicore = notification.getBody() as caption_mashup_multicore;
				
				/*******************
				 * Model Prep
				 * *****************/

				facade.registerProxy(new MessageProxy());
				
				/*******************
				 * View Prep
				 * *****************/
				facade.registerMediator(new AppScreenMediator(shell.appScreen));
				facade.registerMediator(new ModuleLoaderMediator(shell.appScreen));
				//facade.registerMediator(new AlbumMenuMediator(shell.appScreen.albumBrowser));

				sendNotification( StateMachine.ACTION, null, ShellConstants.STARTED );
				
			}
			catch(e:Error)
			{
				
				trace("STARTSHELL Error caught: "+e);
				trace("Error message: "+e.message);
				sendNotification( StateMachine.ACTION, e.message, ShellConstants.STARTUP_FAILED);
			}
			
		}
	}
}