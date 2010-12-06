package com.captionmashup.modules.core.debug.facade
{

	import com.captionmashup.modules.core.debug.controller.startup.StartupCommand;
	import com.captionmashup.modules.core.debug.DebugModule;
	
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
			
			registerCommand( ApplicationConstants.STARTUP, StartupCommand );

		}
		
		/**
		 * Application startup
		 * 
		 * @param app a reference to the application component 
		 */  
		public function startup( app:DebugModule ):void
		{
			sendNotification( ApplicationConstants.STARTUP, app );
		}			
	}
}