package com.captionmashup.shell.controller.state.startup
{

	import com.captionmashup.common.model.local.dto.AlbumDTO;
	import com.captionmashup.common.model.local.dto.CaptionDTO;
	import com.captionmashup.common.model.local.dto.GenreDTO;
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.common.pipe.message.core.DebugMessage;
	import com.captionmashup.common.pipe.message.core.ViewerMessage;
	import com.captionmashup.common.log.t;
	import com.captionmashup.shell.facade.ShellConstants;
	import com.captionmashup.shell.facade.ShellFacade;
	
	import mx.core.FlexGlobals;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.utilities.statemachine.StateMachine;
	
	/********************************
	 * This command decides what to 
	 * do at application start
	 * 
	 * Default:
	 * 	Switch to caption browsing state
	 * 
	 * Otherwise switch to viewing, 
	 * creating states using flashvars
	 * *****************************/
	public class ConfigureCommand extends SimpleCommand implements ICommand
	{
		private var captionLink:String;
		private var photoLink:String;
		private var albumLink:String;
		private var templateLink:String;
		
		private var viewerMessage:ViewerMessage;
		private var creatorMessage:CreatorMessage;
		private var debugMessage:DebugMessage;
		
		override public function execute( notification :INotification ) : void
		{
			trace("CONFIGURE COMMAND CALLED");
			//Create instances of DTOs so RemoteAlias registration is done
			
			var genreDTO:GenreDTO;
			var albumDTO:AlbumDTO;
			var photoDTO:PhotoDTO;
			var captionDTO:CaptionDTO;
	

			
			//Get Flashvars
			captionLink  = FlexGlobals.topLevelApplication.parameters.captionLink;
			photoLink	 = FlexGlobals.topLevelApplication.parameters.photoLink;
			
			t.obj(FlexGlobals.topLevelApplication.parameters,"Flashvars in ConfigureCommand");

			debugMessage = new DebugMessage(DebugMessage.LOG,"Flashvars from Configure Command",
												FlexGlobals.topLevelApplication.parameters);
			sendNotification(ShellConstants.SEND_MESSAGE_TO_MODULE,debugMessage);
			
			if(!ShellFacade.flashvar_action_taken){
				ShellFacade.flashvar_action_taken = true;

				if(captionLink.length > 0){
					viewerMessage = new ViewerMessage(ViewerMessage.GET_CAPTION,captionLink);
					sendNotification(StateMachine.ACTION,viewerMessage,ShellConstants.ACTION_START_VIEW);
					return;
				}
				if(photoLink.length > 0){
					creatorMessage = new CreatorMessage(CreatorMessage.START_CREATE,
											photoLink,CreatorMessage.HEADER_PHOTO_LINK);
					sendNotification(StateMachine.ACTION,creatorMessage,
									ShellConstants.ACTION_START_CREATE);
					return;
				}
			}
			
			trace("No FlashVars action taken, switching to BROWSING_CAPTIONS state from Configure Command");
			//If no flashvar action taken
			sendNotification(StateMachine.ACTION,null,ShellConstants.ACTION_BROWSE_CAPTIONS);
			
		}
		
	}
}