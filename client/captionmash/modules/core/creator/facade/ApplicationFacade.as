package com.captionmashup.modules.core.creator.facade
{
	import com.captionmashup.modules.core.creator.controller.DisposeCommand;
	import com.captionmashup.modules.core.creator.controller.creation.CancelCreationCommand;
	import com.captionmashup.modules.core.creator.controller.creation.PostCreationCommand;
	import com.captionmashup.modules.core.creator.controller.creation.StartCreationCommand;
	import com.captionmashup.modules.core.creator.controller.frame.AddFrameMacroCommand;
	import com.captionmashup.modules.core.creator.controller.frame.ClearFramesCommand;
	import com.captionmashup.modules.core.creator.controller.frame.DeleteFrameCommand;
	import com.captionmashup.modules.core.creator.controller.frame.SaveFrameCommand;
	import com.captionmashup.modules.core.creator.controller.frame.SwapFrameCommand;
	import com.captionmashup.modules.core.creator.controller.photo.GetAlbumPhotosCommand;
	import com.captionmashup.modules.core.creator.controller.photo.GetSinglePhotoCommand;
	import com.captionmashup.modules.core.creator.controller.photo.GetTemplatePhotosCommand;
	import com.captionmashup.modules.core.creator.controller.startup.StartupCommand;
	import com.captionmashup.modules.core.creator.controller.ui.SendUICommand;
	
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
            registerCommand( ApplicationConstants.DISPOSE, DisposeCommand );
			
			//UI Query
			registerCommand(ApplicationConstants.UI_QUERY,	SendUICommand);
			
			//Caption Commands
			registerCommand(ApplicationConstants.START_CREATION,	StartCreationCommand);
			registerCommand(ApplicationConstants.POST_CREATION,		PostCreationCommand);
			registerCommand(ApplicationConstants.CANCEL_CREATION,	CancelCreationCommand);
			
			//Frame Commands
			registerCommand(ApplicationConstants.ADD_FRAME,		AddFrameMacroCommand);
			registerCommand(ApplicationConstants.SAVE_FRAME, 	SaveFrameCommand);
			registerCommand(ApplicationConstants.DELETE_FRAME,	DeleteFrameCommand);
			registerCommand(ApplicationConstants.SWAP_FRAME,	SwapFrameCommand); //Not implemented
			registerCommand(ApplicationConstants.CLEAR_FRAMES,	ClearFramesCommand);
			
			//Photo Commands
			registerCommand(ApplicationConstants.GET_SINGLE_PHOTO,		GetSinglePhotoCommand);
			registerCommand(ApplicationConstants.GET_ALBUM_PHOTOS,		GetAlbumPhotosCommand);
			registerCommand(ApplicationConstants.GET_TEMPLATE_PHOTOS,		GetTemplatePhotosCommand);
		}
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */  
        public function startup( app:Creator ):void
        {
        	sendNotification( ApplicationConstants.STARTUP, app );
        }			
	}
}