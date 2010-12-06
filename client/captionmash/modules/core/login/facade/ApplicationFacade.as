package com.captionmashup.modules.core.login.facade
{

	import com.captionmashup.modules.core.login.LoginModule;
	import com.captionmashup.modules.core.login.controller.authentication.LoginCommand;
	import com.captionmashup.modules.core.login.controller.authentication.LogoutCommand;
	import com.captionmashup.modules.core.login.controller.registration.CheckEmailCommand;
	import com.captionmashup.modules.core.login.controller.registration.CheckNicknameCommand;
	import com.captionmashup.modules.core.login.controller.registration.CreateUserCommand;
	import com.captionmashup.modules.core.login.controller.startup.StartupCommand;
	import com.captionmashup.modules.core.login.controller.ui.SendUICommand;
	
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
			
			registerCommand(ApplicationConstants.LOGIN,LoginCommand);
			registerCommand(ApplicationConstants.LOGOUT,LogoutCommand);
			
			registerCommand(ApplicationConstants.CHECK_UNIQUE_EMAIL,CheckEmailCommand);
			registerCommand(ApplicationConstants.CHECK_UNIQUE_NICKNAME,CheckNicknameCommand);
			registerCommand(ApplicationConstants.CREATE_USER,CreateUserCommand);
			registerCommand(ApplicationConstants.UI_QUERY, SendUICommand);
           //registerCommand( ApplicationConstants.MESSAGE_FROM_SHELL_RECEIVED, AddMessageCommand );
           //registerCommand( ApplicationConstants.DISPOSE, DisposeCommand );
			
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */  
        public function startup( app:LoginModule):void
        {
        	sendNotification( ApplicationConstants.STARTUP, app );
        }			
	}
}