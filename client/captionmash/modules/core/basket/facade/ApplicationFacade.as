package com.captionmashup.modules.core.basket.facade
{
	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.modules.core.basket.BasketModule;
	import com.captionmashup.modules.core.basket.controller.photo.AddPhotoCommand;
	import com.captionmashup.modules.core.basket.controller.startup.StartupCommand;
	
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
			
			//Photo Basket
			registerCommand(ApplicationConstants.ADD_PHOTO,AddPhotoCommand);
		}
		
		/**
		 * Application startup
		 * 
		 * @param app a reference to the application component 
		 */  
		public function startup( app:BasketModule ):void
		{
			sendNotification( STARTUP, app );
		}
	}
}