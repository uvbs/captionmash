package com.captionmashup.shell.facade
{
	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.shell.controller.ModuleRemovedCommand;
	import com.captionmashup.shell.controller.module.creator.LoadCreatorAsyncMacroCommand;
	import com.captionmashup.shell.controller.module.facebook.LoadFacebookAsyncMacroCommand;
	import com.captionmashup.shell.controller.module.login.LoginCommand;
	import com.captionmashup.shell.controller.state.navigation.BrowseAlbumsCommand;
	import com.captionmashup.shell.controller.state.navigation.BrowseCaptionsCommand;
	import com.captionmashup.shell.controller.state.navigation.CreateCommand;
	import com.captionmashup.shell.controller.state.navigation.ViewCommand;
	import com.captionmashup.shell.controller.state.startup.ConfigureCommand;
	import com.captionmashup.shell.controller.state.startup.FailCommand;
	import com.captionmashup.shell.controller.state.startup.PlumbCommand;
	import com.captionmashup.shell.controller.state.startup.StartupCommand;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	/**
	 * Concrete Facade for the Main App / Shell.
	 */
	public class ShellFacade extends Facade implements IFacade
	{
		//
		// vars
		public static const DEBUG_MODE:Boolean = CommonConstants.DEBUG_MODE;
		//
		// const	
		public static const STARTUP:String = 'startup';
		public static var flashvar_action_taken:Boolean = false;
		//public static const MODULE_ADDED: String = "moduleAdded";
		public static const MODULE_REMOVED: String = "moduleRemoved";

		//public static const SEND_MESSAGE_TO_MODULE: String = "sendMessageToModule";				
		public static const MESSAGE_FROM_MODULE_RECEIVED: String = "messageFromModuleReceived";
		
		//Used to detect if latest captions should be called on switching to Browsing_Captions state
		//True: when user clicks on captions, when caption creation is complete
		//False: when user starts viewing a caption
		public static var is_browser_default_refresh:Boolean = true;
		//
		// instances
				
		/**
		* Constructor of ApplicationFacade
		*
		*/				
		public function ShellFacade( key:String )
		{
			super(key);	
		}

        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String ) : ShellFacade
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ]  = new ShellFacade( key );
            return instanceMap[ key ] as ShellFacade;
        }
        
	    /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController(); 
			
			//Startup
            registerCommand( STARTUP,StartupCommand );
	
			//Register the state commands. The StateMachince is configured to 
			//use these commands for the process of changing states.
			registerCommand(ShellConstants.PLUMB, 			PlumbCommand );
			registerCommand(ShellConstants.CONFIGURE, 		ConfigureCommand);
			registerCommand(ShellConstants.VIEW,			ViewCommand);
			registerCommand(ShellConstants.CREATE,			CreateCommand);
			registerCommand(ShellConstants.FAIL, 			FailCommand);
			registerCommand(ShellConstants.BROWSE_CAPTIONS,	BrowseCaptionsCommand);
			registerCommand(ShellConstants.BROWSE_ALBUMS,	BrowseAlbumsCommand);
			registerCommand(ShellConstants.LOGIN,			LoginCommand);
			//registerCommand( ASSEMBLE,  AssembleCommand );
			//registerCommand( FAIL, 		FailCommand );
			
			
			/************************************
			 * Modules
			 * **********************************/
			//Module Addition
			
			//Module Communication
            //registerCommand( MESSAGE_FROM_MODULE_RECEIVED, AddMessageCommand );
			
			//Module Removal
            //registerCommand( MODULE_REMOVED, ModuleRemovedCommand );
			
			//Creator
			registerCommand(ShellConstants.LOAD_CREATOR, LoadCreatorAsyncMacroCommand);
			//registerCommand(ShellConstants.REMOVE_CREATOR,RemoveModuleCommand);
			
			//Facebook
			registerCommand(ShellConstants.LOAD_FACEBOOK,LoadFacebookAsyncMacroCommand);
			
			//Flickr
			//registerCommand(ShellConstants.LOAD_FLICKR,LoadModuleCommand);
		

        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */  
        public function startup( app: caption_mashup_multicore ):void
        {
        	sendNotification( STARTUP, app );
        }
			
	}
}