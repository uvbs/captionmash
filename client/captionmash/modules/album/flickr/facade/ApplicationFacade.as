package com.captionmashup.modules.album.flickr.facade
{

	import com.captionmashup.modules.album.flickr.controller.startup.StartupCommand;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	/**
	 * Concrete Facade for the Simple Module
	 */
	public class ApplicationFacade extends Facade implements IFacade
	{
		//
		// const	
		public static const DEBUG_MODE:Boolean = true;
		
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
            //registerCommand( MESSAGE_FROM_SHELL_RECEIVED, AddMessageCommand );
            //registerCommand( DISPOSE, DisposeCommand );
			
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */  
        public function startup( app:Flickr ):void
        {
        	sendNotification( STARTUP, app );
        }			
	}
}