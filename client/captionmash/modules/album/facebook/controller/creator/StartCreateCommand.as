package com.captionmashup.modules.album.facebook.controller.creator
{
	
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.modules.album.facebook.model.proxy.PhotoDTOProxy;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	/**********************************************************
	 * StartCreateCommand
	 * 
	 * This command creates a CaptionDTO object using
	 * FriendProxy,AlbumProxy,PhotoProxy,UserProxy and sends a 
	 * CreatorMessage to shell, with CaptionDTO object as body
	 * *********************************************************/
	public class StartCreateCommand extends SimpleCommand implements ICommand
	{		
		override public function execute(notification:INotification):void
		{
			trace("FACEBOOK StartCreateCommand COMMAND CALLED");
			var photoDTOProxy:PhotoDTOProxy = facade.retrieveProxy(PhotoDTOProxy.NAME) as PhotoDTOProxy;
			
			var creatorMessage:CreatorMessage = new CreatorMessage(CreatorMessage.START_CREATE,
																		photoDTOProxy.photoDTO);
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,creatorMessage);
		}
	}
}