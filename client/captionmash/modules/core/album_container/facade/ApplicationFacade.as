package com.captionmashup.modules.core.album_container.facade
{
	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.modules.core.album_container.AlbumContainerModule;
	import com.captionmashup.modules.core.album_container.controller.photos.ListLatestAddedPhotosCommand;
	import com.captionmashup.modules.core.album_container.controller.photos.ListLatestCaptionedPhotosCommand;
	import com.captionmashup.modules.core.album_container.controller.startup.StartupCommand;
	import com.captionmashup.modules.core.album_container.controller.ui.SendUICommand;
	import com.captionmashup.modules.core.album_container.controller.ui.facebook.GetFacebookUICommand;
	import com.captionmashup.modules.core.album_container.controller.ui.facebook.SetFacebookUICommand;
	import com.captionmashup.modules.core.album_container.controller.ui.local_album.SetLocalAlbumUICommand;
	
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
			
			//Send UI to shell
			registerCommand(ApplicationConstants.UI_QUERY, SendUICommand);
			
			//Set local UI
			registerCommand(ApplicationConstants.GET_FACEOOK_UI,GetFacebookUICommand);
			registerCommand(ApplicationConstants.SET_FACEBOOK_UI,SetFacebookUICommand);
			registerCommand(ApplicationConstants.SET_LOCAL_ALBUM_BROWSER_UI,SetLocalAlbumUICommand)
			
			registerCommand(ApplicationConstants.LIST_LATEST_CAPTIONED_PHOTOS, ListLatestCaptionedPhotosCommand);
			registerCommand(ApplicationConstants.LIST_LATEST_ADDED_PHOTOS,ListLatestAddedPhotosCommand);
		}
		
		/**
		 * Application startup
		 * 
		 * @param app a reference to the application component 
		 */  
		public function startup( app:AlbumContainerModule ):void
		{
			sendNotification( STARTUP, app );
		}
	}
}