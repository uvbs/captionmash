package com.captionmashup.modules.core.album_manager.facade
{
	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.modules.core.album_manager.AlbumManagerModule;
	import com.captionmashup.modules.core.album_manager.controller.album.CreateAlbumCommand;
	import com.captionmashup.modules.core.album_manager.controller.album.DeleteAlbumCommand;
	import com.captionmashup.modules.core.album_manager.controller.album.ListUserAlbumsCommand;
	import com.captionmashup.modules.core.album_manager.controller.authentication.LogoutCommand;
	import com.captionmashup.modules.core.album_manager.controller.navigation.CloseManagerCommand;
	import com.captionmashup.modules.core.album_manager.controller.photo.DeletePhotoCommand;
	import com.captionmashup.modules.core.album_manager.controller.photo.ListAlbumPhotosCommand;
	import com.captionmashup.modules.core.album_manager.controller.photo.SavePhotoCommand;
	import com.captionmashup.modules.core.album_manager.controller.photo.UploadPhotoCommand;
	import com.captionmashup.modules.core.album_manager.controller.startup.StartupCommand;
	import com.captionmashup.modules.core.album_manager.facade.ApplicationConstants;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade
	{
		
		// const	
		public static const DEBUG_MODE:Boolean = CommonConstants.DEBUG_MODE;
		
		public static const STARTUP:String = 'startup';
		
		public function ApplicationFacade(key:String)
		{
			super(key);
		}
		
		/**
		 * Singleton ApplicationFacade Factory Method
		 */
		public static function getInstance( key:String ) : ApplicationFacade
		{
			if ( instanceMap[ key ] == null ) 
				instanceMap[ key ]  = new ApplicationFacade( key );
			
			return ApplicationFacade( instanceMap[ key ] );
		}
		
		/**
		 * Register Commands with the Controller 
		 */
		override protected function initializeController( ) : void 
		{
			super.initializeController(); 
			
			registerCommand( STARTUP, StartupCommand );
			
			registerCommand(ApplicationConstants.UPLOAD_TO_ALBUM, 	UploadPhotoCommand);
			registerCommand(ApplicationConstants.SAVE_PHOTO, 		SavePhotoCommand);
			registerCommand(ApplicationConstants.DELETE_PHOTO, 		DeletePhotoCommand);
			registerCommand(ApplicationConstants.GET_ALBUM_PHOTOS,	ListAlbumPhotosCommand);
			
			
			registerCommand(ApplicationConstants.GET_USER_ALBUMS, ListUserAlbumsCommand);
			registerCommand(ApplicationConstants.CREATE_ALBUM,CreateAlbumCommand);
			registerCommand(ApplicationConstants.DELETE_ALBUM,DeleteAlbumCommand);
			
			registerCommand(ApplicationConstants.CLOSE_MANAGER,CloseManagerCommand);
			
			registerCommand(ApplicationConstants.USER_LOGOUT,LogoutCommand);
		}
		
		/**
		 * Application startup
		 * 
		 * @param app a reference to the application component 
		 */  
		public function startup( app:AlbumManagerModule):void
		{
			sendNotification( STARTUP, app );
		}
	}
}