package com.captionmashup.modules.album.facebook.facade
{
	//import captionmashup.modules.creator.controller.startup.StartupCommand;
	
	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.modules.album.facebook.controller.basket.AddToBasketMacroCommand;
	import com.captionmashup.modules.album.facebook.controller.browse.LoadAlbumsCommand;
	import com.captionmashup.modules.album.facebook.controller.browse.LoadPhotosCommand;
	import com.captionmashup.modules.album.facebook.controller.creator.StartCreateMacroCommand;
	import com.captionmashup.modules.album.facebook.controller.login.InitAsyncMacroCommand;
	import com.captionmashup.modules.album.facebook.controller.startup.StartupCommand;
	import com.captionmashup.modules.album.facebook.controller.ui.SendUICommand;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	/**
	 * Concrete Facade for the Simple Module
	 */
	public class ApplicationFacade extends Facade implements IFacade
	{
		//
		// const	
		public static const DEBUG_MODE:Boolean = CommonConstants.DEBUG_MODE;
		
		public static const STARTUP:String = 'startup';
		public static const MESSAGE_FROM_SHELL_RECEIVED:String = 'messageFromShellReceived';
		public static const SEND_MESSAGE_TO_SHELL:String = 'sendMessageToShell';
		public static const DISPOSE:String = 'dispose';				
		//
		// instances
				
		/**
		* Constructor of ApplicationFacade
		*
		*/				
		public function ApplicationFacade( key:String )
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

			
			registerCommand(ApplicationConstants.LOAD_USER_DATA,InitAsyncMacroCommand);

			//UI_QUERY
			registerCommand(ApplicationConstants.UI_QUERY,SendUICommand);
			
			//Browse Commands
			registerCommand(ApplicationConstants.LOAD_ALBUMS,LoadAlbumsCommand);
			registerCommand(ApplicationConstants.LOAD_PHOTOS,LoadPhotosCommand);
			
			//Creation Commands
			registerCommand(ApplicationConstants.START_CREATE,StartCreateMacroCommand);
			
			//Basket command
			registerCommand(ApplicationConstants.ADD_TO_BASKET,AddToBasketMacroCommand);
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */  
        public function startup( app:Facebook ):void
        {
        	sendNotification( STARTUP, app );
        }			
	}
}