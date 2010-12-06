package com.captionmashup.modules.core.caption_browser.facade
{
	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.modules.core.caption_browser.CaptionBrowserModule;
	import com.captionmashup.modules.core.caption_browser.controller.caption.LatestCaptionsCommand;
	import com.captionmashup.modules.core.caption_browser.controller.startup.StartupCommand;
	import com.captionmashup.modules.core.caption_browser.controller.ui.SendUICommand;
	
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
			
			registerCommand(ApplicationConstants.LATEST_CAPTIONS,LatestCaptionsCommand);
			registerCommand(ApplicationConstants.UI_QUERY, SendUICommand);

		}
		
		/**
		 * Application startup
		 * 
		 * @param app a reference to the application component 
		 */  
		public function startup( app:CaptionBrowserModule):void
		{
			sendNotification( STARTUP, app );
		}
	}
}