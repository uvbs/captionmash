package com.captionmashup.modules.album.local.facade
{
	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.modules.album.local.LocalAlbumModule;
	import com.captionmashup.modules.album.local.controller.album.ListGenreAlbumsCommand;
	import com.captionmashup.modules.album.local.controller.album.ListUserAlbumsCommand;
	import com.captionmashup.modules.album.local.controller.batch.BatchAddToBasketCommand;
	import com.captionmashup.modules.album.local.controller.batch.BatchCreateCommand;
	import com.captionmashup.modules.album.local.controller.genre.ListGenresCommand;
	import com.captionmashup.modules.album.local.controller.member.ListMembersCommand;
	import com.captionmashup.modules.album.local.controller.photo.ListPhotosCommand;
	import com.captionmashup.modules.album.local.controller.startup.StartupCommand;
	import com.captionmashup.modules.album.local.controller.ui.SendUICommand;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade
	{
		
		// const	
		public static const DEBUG_MODE:Boolean = CommonConstants.DEBUG_MODE;
		
		public static const STARTUP:String = 'startup';
		public static var isDisplayed:Boolean = false;
		
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
			registerCommand(ApplicationConstants.LIST_GENRES,ListGenresCommand);
			registerCommand(ApplicationConstants.LIST_MEMBERS,ListMembersCommand);
			registerCommand(ApplicationConstants.LIST_GENRE_ALBUMS,ListGenreAlbumsCommand);
			registerCommand(ApplicationConstants.LIST_USER_ALBUMS ,ListUserAlbumsCommand);
			registerCommand(ApplicationConstants.LIST_PHOTOS,ListPhotosCommand);
			
			registerCommand(ApplicationConstants.ADD_ALL_PHOTOS_TO_BASKET,BatchAddToBasketCommand);
			registerCommand(ApplicationConstants.CAPTION_ALL_PHOTOS,BatchCreateCommand);
			
			registerCommand(ApplicationConstants.UI_QUERY,SendUICommand);
			

		}
		
		/**
		 * Application startup
		 * 
		 * @param app a reference to the application component 
		 */  
		public function startup( app:LocalAlbumModule ):void
		{
			sendNotification( STARTUP, app );
		}
	}
}