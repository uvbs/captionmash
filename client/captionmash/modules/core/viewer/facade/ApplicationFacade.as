package com.captionmashup.modules.core.viewer.facade
{
	
	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.modules.core.viewer.ViewerModule;
	import com.captionmashup.modules.core.viewer.controller.basket.AddToBasketCommand;
	import com.captionmashup.modules.core.viewer.controller.caption.GetCaptionCommand;
	import com.captionmashup.modules.core.viewer.controller.caption.StartViewCommand;
	import com.captionmashup.modules.core.viewer.controller.caption.StopViewCommand;
	import com.captionmashup.modules.core.viewer.controller.creator.StartCreateCommand;
	import com.captionmashup.modules.core.viewer.controller.startup.StartupCommand;
	
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
			
			registerCommand(ApplicationConstants.STARTUP, StartupCommand );
			registerCommand(ApplicationConstants.START_VIEW,StartViewCommand);
			registerCommand(ApplicationConstants.STOP_VIEW,StopViewCommand);
			registerCommand(ApplicationConstants.GET_CAPTION,GetCaptionCommand);
			
			registerCommand(ApplicationConstants.ADD_TO_BASKET,AddToBasketCommand);
			registerCommand(ApplicationConstants.START_CREATE,StartCreateCommand);
			//registerCommand( ApplicationConstants.MESSAGE_FROM_SHELL_RECEIVED, AddMessageCommand );
			//registerCommand( ApplicationConstants.DISPOSE, DisposeCommand );
			
		}
		
		/**
		 * Application startup
		 * 
		 * @param app a reference to the application component 
		 */  
		public function startup( app:ViewerModule ):void
		{
			sendNotification( ApplicationConstants.STARTUP, app );
		}			
	}
}