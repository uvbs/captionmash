package com.captionmashup.modules.album.facebook.controller.common
{
	import com.captionmashup.common.model.foreign.facebook.User;
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.album.facebook.model.dto.Album;
	import com.captionmashup.modules.album.facebook.model.dto.Friend;
	import com.captionmashup.modules.album.facebook.model.dto.Photo;
	import com.captionmashup.modules.album.facebook.model.proxy.AlbumProxy;
	import com.captionmashup.modules.album.facebook.model.proxy.FriendProxy;
	import com.captionmashup.modules.album.facebook.model.proxy.PhotoDTOProxy;
	import com.captionmashup.modules.album.facebook.model.proxy.PhotoProxy;
	import com.captionmashup.modules.album.facebook.model.proxy.UserProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**************************************
	 * This command is used to create a
	 * PhotoDTO object and store it in
	 * the PhotoDTOProxy
	 * 
	 * It is not called directly but used
	 * by macro commands
	 * ***********************************/
	public class CreatePhotoDTOCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			trace("FACEBOOK StartCreateCommand COMMAND CALLED");
			var photoDTOProxy:PhotoDTOProxy = facade.retrieveProxy(PhotoDTOProxy.NAME) as PhotoDTOProxy;
			var friendProxy:FriendProxy 	= facade.retrieveProxy(FriendProxy.NAME) as FriendProxy;
			var albumProxy:AlbumProxy 		= facade.retrieveProxy(AlbumProxy.NAME) as AlbumProxy;
			var photoProxy:PhotoProxy 		= facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;
			var userProxy:UserProxy 		= facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			
			var activeFriend:Friend 	= friendProxy.activeContent as Friend;
			var activeAlbum:Album 		= albumProxy.activeContent as Album;
			var activePhoto:Photo 		= photoProxy.activeContent as Photo;
			var user:User 				= userProxy.user;
			
			var photoDTO:PhotoDTO = new PhotoDTO();
			
			photoDTO.network_name = user.network;
			photoDTO.owner_id 	  = activeAlbum.owner_id;
			photoDTO.album_id 	  = activeAlbum.album_id;
			photoDTO.photo_id 	  = activePhoto.photo_id;
			photoDTO.thumb_path   = activePhoto.thumb_path;
			photoDTO.photo_path   = activePhoto.photo_path;
				
			t.obj(activeFriend,"activeFriend");
			t.obj(activeAlbum,"activeAlbum");
			t.obj(activePhoto,"activePhoto");
			t.obj(user,"user");
			t.obj(photoDTO,"photoDTO");
			
			photoDTOProxy.setData(photoDTO);
		}
	}
}