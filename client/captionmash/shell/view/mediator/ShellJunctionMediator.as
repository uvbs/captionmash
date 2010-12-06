
package com.captionmashup.shell.view.mediator
{

	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.common.pipe.PipeAwareModuleConstants;
	import com.captionmashup.common.pipe.message.album.FacebookMessage;
	import com.captionmashup.common.pipe.message.album.LocalAlbumMessage;
	import com.captionmashup.common.pipe.message.core.AlbumContainerMessage;
	import com.captionmashup.common.pipe.message.core.BasketMessage;
	import com.captionmashup.common.pipe.message.core.CaptionBrowserMessage;
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.common.pipe.message.core.LoginMessage;
	import com.captionmashup.common.pipe.message.core.NavigationMessage;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.common.pipe.message.core.ViewerMessage;
	import com.captionmashup.shell.facade.ShellConstants;
	import com.captionmashup.shell.facade.ShellFacade;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Pipe;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeMerge;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeSplit;
	import org.puremvc.as3.multicore.utilities.statemachine.StateMachine;
	
	public class ShellJunctionMediator extends JunctionMediator
	{

		//
		// vars
		private var moduleLoaderMediator:ModuleLoaderMediator;
		//
		// const	
		public static const NAME:String = 'ShellJunctionMediator';
		//
		// instances
					
		
		public function ShellJunctionMediator(junction:Junction )
		{
			super( NAME,junction);
		}
		
		override public function onRegister():void{
			moduleLoaderMediator = facade.retrieveMediator(ModuleLoaderMediator.NAME) as ModuleLoaderMediator;
		}
		
		public function getJunction():Junction{
			return super.junction;
		}

		
		public function sendMessage(message:Message):void
		{
			trace("Sending message from ShellJunctionMediator");
			junction.sendMessage(PipeAwareModuleConstants.STDOUT, message);
		}
		
		
		/**
		 * ShellJunction related Notification list.
		 */
		override public function listNotificationInterests():Array
		{
 			var interests:Array = super.listNotificationInterests();			
			//interests.push( ShellFacade.MODULE_ADDED );
			interests.push( ShellConstants.SEND_MESSAGE_TO_MODULE );
			interests.push( ShellConstants.SEND_MESSAGE_TO_CREATOR );	
			return interests; 
		}

		/**
		 * Handle ShellJunction related Notifications
		 * 
		 * @param 	note	Notification sended by an actor
		 */
		override public function handleNotification( note:INotification ):void
		{
			switch( note.getName() )
			{							

				case ShellConstants.SEND_MESSAGE_TO_MODULE:
					junction.sendMessage( PipeAwareModuleConstants.STDOUT,note.getBody() as IPipeMessage);
					break;
				
				//Sends CreatorMessage
				case ShellConstants.SEND_MESSAGE_TO_CREATOR:
					junction.sendMessage( PipeAwareModuleConstants.CREATOR,note.getBody() as Message);
					//junction.sendMessage(PipeAwareModuleConstants.STDOUT, new CreatorMessage(CreatorMessage.START_CREATE));
					
					break;
				// Let super handle the rest (ACCEPT_OUTPUT_PIPE, ACCEPT_INPUT_PIPE, SEND_TO_LOG)								
				default:
					super.handleNotification(note);
					
			}			

		}
			
		
		/**
		 * Handle incoming pipe messages for the ShellJunction.
		 * 
		 * @param message 	Message typed as IPipeMessage
		 */
		override public function handlePipeMessage( message:IPipeMessage ):void
		{
			switch ( Message(message).getType() )
			{
				case PipeAwareModuleConstants.MODULE_TO_SHELL_MESSAGE:
					trace("message received in ShellJunctionMediator.handlePipeMessage, PipeAwareModuleConstants.MODULE_TO_SHELL_MESSAGE");
					//sendNotification( ApplicationFacade.MESSAGE_FROM_MODULE_RECEIVED,	Message(message).getBody() );
					break;
				
				case NavigationMessage.ALBUM_HOME:
					trace("handling NavigationMessage.ALBUM_HOME at shellJunctionMediator");
					//End creation
					//sendNotification(ShellConstants.BROWSE_IMAGES);
					sendNotification(StateMachine.ACTION,message,ShellConstants.ACTION_BROWSE_ALBUMS);
					junction.sendMessage(PipeAwareModuleConstants.STDOUT,message);
					break;
				
				case CreatorMessage.END_CREATE:
					trace("handling CreatorMessage.END_CREATE in ShellJunctionMediator.handlePipeMessage");
					if(message.getBody() != null){
						ShellFacade.is_browser_default_refresh = true;
					}
					sendNotification(StateMachine.ACTION,message,ShellConstants.ACTION_END_CREATE);
					//ApplicationNotifications.
					break;
				
				case CreatorMessage.START_CREATE:
					trace("handling CreatorMessage.END_CREATE in ShellJunctionMediator.handlePipeMessage");
					sendNotification(StateMachine.ACTION,message,ShellConstants.ACTION_START_CREATE);
					break;
				
				case ViewerMessage.START_VIEW:
					ShellFacade.is_browser_default_refresh = false;
					sendNotification(StateMachine.ACTION,message,ShellConstants.ACTION_START_VIEW);
					break;
				
				case ViewerMessage.END_VIEW:
					trace("ViewerMessage received in shell, ENDING VIEWING STATE");
					sendNotification(StateMachine.ACTION,message,ShellConstants.ACTION_END_VIEW);
					break;
				
				case FacebookMessage.LOAD_MODULE:
					
					trace("Shell constants: "+ShellConstants.FACEBOOK_MODULE_URL);
					trace("Common constants: "+CommonConstants.FACEBOOK_MODULE_URL);
					sendNotification(ShellConstants.LOAD_FACEBOOK,
								moduleLoaderMediator.facebookLoader,
								CommonConstants.FACEBOOK_MODULE_URL);
					break;
				
				case CaptionBrowserMessage.SET_UI:
					trace("CaptionBrowserMessage.SET_UI received in shellJunctionMediator");
					sendNotification(ShellConstants.ADD_CAPTION_BROWSER,message.getBody());
					break;
				
				case AlbumContainerMessage.SET_UI:
					trace("AlbumContainerMessage.SET_UI received in shellJunctionMediator");
					sendNotification(ShellConstants.ADD_ALBUM_CONTAINER,message.getBody());
					break;
				
				case LoginMessage.SET_UI:
					sendNotification(ShellConstants.ADD_LOGIN_BAR,message.getBody());
					break;
				
				case LoginMessage.SET_USER_DATA: //Admin Debug Button display
					sendNotification(ShellConstants.USER_RECEIVED,message.getBody());
					junction.sendMessage(PipeAwareModuleConstants.STDOUT,message);
					break;
				
				case CreatorMessage.SET_UI:
					sendNotification(ShellConstants.ADD_CREATOR,message.getBody());
					break;
				
				default:
					trace("Sending default from shell, message: "+message.getType());
					junction.sendMessage(PipeAwareModuleConstants.STDOUT,message);
					if(message.getBody() != null){
						trace("Default message body: "+message.getBody());
					}
			}
		}
			
		/**
		 * Connect the module using pipes and its TeeMerge and TeeSplit
		 * 
		 * @param module					Module typed as IPipeAwareModule
		 * @param shellToModulePipeName 	String
		 * 
		 * If not pipe name is specified, STDOUT is connected to module's STDIN
		 * Otherwise new dedicated pipe is created and connected to module's STDIN
		 */
		public function connectModule( module:IPipeAware, shellToModulePipeName:String = null):void
		{
			// module -> shell
			var moduleToShell: Pipe = new Pipe();
			module.acceptOutputPipe( PipeAwareModuleConstants.STDOUT, moduleToShell );
			
			var shellInFitting: TeeMerge = junction.retrievePipe( PipeAwareModuleConstants.STDIN ) as TeeMerge;
			shellInFitting.connectInput( moduleToShell );
			
			// shell -> module
			var shellToModule: Pipe = new Pipe();
			module.acceptInputPipe( PipeAwareModuleConstants.STDIN, shellToModule );
			
			//Connect STDOUT as default output to module
			if(shellToModulePipeName == null){
				var shellOutFitting: TeeSplit = junction.retrievePipe( PipeAwareModuleConstants.STDOUT) as TeeSplit;
				shellOutFitting.connect( shellToModule );
			}else{
				//Connect new dedicated pipe to module using shellToModulePipeName
				var dedicatedPipe:IPipeFitting = new Pipe();
				junction.registerPipe(shellToModulePipeName,Junction.OUTPUT,dedicatedPipe);
				dedicatedPipe.connect(shellToModule);
			}
			trace("ShellJunctionMediator plumbing complete :"+module);
		}

		/**
		 * Disconnect the pipes from shell to module 
		 */
		public function disconnectModule(shellToModulePipeName:String,moduleToShellPipeName:String = null):void
		{	
			junction.removePipe(shellToModulePipeName);
			
			if(moduleToShellPipeName != null){
				junction.removePipe(moduleToShellPipeName);
			}
		}
				
	}
}