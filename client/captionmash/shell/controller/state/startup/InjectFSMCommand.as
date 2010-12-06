package com.captionmashup.shell.controller.state.startup
{
	import com.captionmashup.shell.facade.ShellConstants;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.utilities.statemachine.FSMInjector;
	
	public class InjectFSMCommand extends SimpleCommand implements ICommand
	{
		override public function execute( notification :INotification ) : void
		{
			trace("SHELL INJECTFSM COMMAND CALLED");
			
			var fsm:XML = 
				<fsm initial={ShellConstants.STARTING}>
					
					<!-- STARTUP THE SHELL -->
					<state name={ShellConstants.STARTING}>
						<transition action={ShellConstants.STARTED} 
									target={ShellConstants.PLUMBING}/>
			
						<transition action={ShellConstants.STARTUP_FAILED} 
									target={ShellConstants.FAILING}/>
					</state>
			
					<!-- PLUMB THE CORES -->								
					<state name={ShellConstants.PLUMBING} changed={ShellConstants.PLUMB}>
	
					   <transition 	action={ShellConstants.PLUMBED} 
									target={ShellConstants.CONFIGURING}/>

						<transition action={ShellConstants.PLUMB_FAILED} 
									target={ShellConstants.FAILING}/>
						
					</state>
					<!-- RETRIEVE, DISTRIBUTE and PARSE CONFIGURATION -->
					<state name={ShellConstants.CONFIGURING} changed={ShellConstants.CONFIGURE}>
	
					   	<transition	action={ShellConstants.ACTION_BROWSE_CAPTIONS} 
									target={ShellConstants.BROWSING_CAPTIONS}/>
			
					   	<transition	action={ShellConstants.ACTION_BROWSE_ALBUMS} 
									target={ShellConstants.BROWSING_ALBUMS}/>
			
					   	<transition	action={ShellConstants.ACTION_START_VIEW} 
									target={ShellConstants.VIEWING}/>
			
					   	<transition	action={ShellConstants.ACTION_START_CREATE} 
									target={ShellConstants.CREATING}/>
						
						<transition action={ShellConstants.CONFIG_FAILED} 
									target={ShellConstants.FAILING}/>
						
					</state>		

			
					<!-- BROWSING CAPTIONS -->
					<state name={ShellConstants.BROWSING_CAPTIONS} changed={ShellConstants.BROWSE_CAPTIONS}>
						<transition	action={ShellConstants.ACTION_START_CREATE} 
								target={ShellConstants.CREATING}/>
					
					<transition	action={ShellConstants.ACTION_START_VIEW} 
								target={ShellConstants.VIEWING}/>
					
					<transition	action={ShellConstants.ACTION_BROWSE_ALBUMS} 
								target={ShellConstants.BROWSING_ALBUMS}/>
											
					</state>
					
					<!-- BROWSING ALBUMS-->
					<state name={ShellConstants.BROWSING_ALBUMS} changed={ShellConstants.BROWSE_ALBUMS}>
						<transition	action={ShellConstants.ACTION_START_CREATE} 
								target={ShellConstants.CREATING}/>
					
					<transition	action={ShellConstants.ACTION_BROWSE_CAPTIONS} 
								target={ShellConstants.BROWSING_CAPTIONS}/>
											
					</state>
			

					<!--CREATING CAPTION -->
					<state name={ShellConstants.CREATING} changed={ShellConstants.CREATE}>
						<transition	action={ShellConstants.ACTION_END_CREATE} 
									target={ShellConstants.BROWSING_CAPTIONS}/>
			
						<transition	action={ShellConstants.ACTION_BROWSE_CAPTIONS} 
									target={ShellConstants.BROWSING_CAPTIONS}/>
				
						<transition	action={ShellConstants.ACTION_BROWSE_ALBUMS} 
									target={ShellConstants.BROWSING_ALBUMS}/>
						
						<transition	action={ShellConstants.CREATE_FAILED} 
									target={ShellConstants.FAILING}/>
			
					</state>
			
					<!--VIEWING CAPTION-->
					<state name={ShellConstants.VIEWING} changed={ShellConstants.VIEW}>
					<transition	action={ShellConstants.ACTION_START_CREATE} 
								target={ShellConstants.CREATING}/>
			
					<transition	action={ShellConstants.ACTION_END_VIEW} 
								target={ShellConstants.BROWSING_CAPTIONS}/>

					</state>
					<!-- REPORT FAILURE FROM ANY STATE -->
					<state name={ShellConstants.FAILING} changed={ShellConstants.FAIL}/>

				</fsm>;
			
			// Create and inject the StateMachine 
			var injector:FSMInjector = new FSMInjector( fsm );
			injector.initializeNotifier(this.multitonKey);
			injector.inject();
			
		}
	}
}