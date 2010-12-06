package com.captionmashup.shell.facade
{
	import com.captionmashup.common.CommonConstants;

	public class ShellConstants
	{
		public function ShellConstants()
		{
		}
		/*******************************************************
		 * NOTIFICATIONS
		 * ****************************************************/	
		//Messaging Notifications
		public static const SEND_MESSAGE_TO_CREATOR:String 			= "note/message/creator";
		public static const SEND_MESSAGE_TO_MODULE:String 			= "note/message/standard";
		
		//Admin Debug notifications
		public static const USER_RECEIVED:String = "note/user_received";
		
		//CaptionList Notifications
		public static const CAPTION_SELECTED:String = "note/caption_selected";
		
		
		/*************************************************
		 * VIEW COMPONENT GET / SET NOTIFICATIONS
		 * ***********************************************/
		public static const ADD_CAPTION_BROWSER:String		= "note/add_caption_browser";
		public static const ADD_LOCAL_ALBUM_BROWSER:String	= "note/add_local_album_browser";
		public static const ADD_ALBUM_CONTAINER:String		= "note/add_album_container";
		public static const ADD_LOGIN_BAR:String			= "note/add_login_bar";
		public static const ADD_CREATOR:String				= "note/add_creator";
		/**************************************************************
		 * FSM CONSTANTS ( In order of runtime sequence /FSM )
		 * ************************************************************/
		public static const STARTING:String   	  		    = "state/starting/puremvc";
		public static const STARTUP:String  		  	    = "note/startup";
		public static const STARTED:String   	  		    = "acion/completed/startup";
		public static const STARTUP_FAILED:String  		    = "action/startup/failed";
		
		public static const PLUMBING:String  		  	    = "state/plumbing";
		public static const PLUMB:String  				    = "note/plumb";
		public static const PLUMBED:String  		  	    = "action/plumbing";
		public static const PLUMB_FAILED:String  		    = "action/plumbing/failed";
		
		public static const CONFIGURING:String  	  	    = "state/configuring";
		public static const CONFIGURE:String  			    = "note/configure";
		public static const CONFIG_FAILED:String  		    = "action/confguration/failed";
		
		public static const ACTION_BROWSE_CAPTIONS:String  	= "action/browse_captions";
		public static const BROWSING_CAPTIONS:String  	  	= "state/browsing_captions";
		public static const BROWSE_CAPTIONS:String  		= "note/browse_captions";
		
		public static const ACTION_BROWSE_ALBUMS:String  	= "action/browse_albums";
		public static const BROWSING_ALBUMS:String  	  	= "state/browsing_albums";
		public static const BROWSE_ALBUMS:String  			= "note/browse_albums";
		
		public static const VIEWING:String				    = "state/viewing";
		public static const VIEW:String					    = "note/view";
		public static const ACTION_START_VIEW:String		= "action/start_view";
		public static const ACTION_END_VIEW:String			= "action/end_view";
		
		public static const CREATING:String  	  	  		= "state/creating";
		public static const CREATE:String  					= "note/create";
		public static const CREATE_FAILED:String  			= "action/creation/failed";
		public static const ACTION_START_CREATE:String  	= "action/start_create";
		public static const ACTION_END_CREATE:String  		= "action/end_create";
		
		public static const AUTHENTICATING:String			= "state/authenticating";
		public static const LOGIN:String					= "note/login";
		public static const START_LOGIN:String				= "action/try_login";
		public static const LOGIN_SUCCESS:String			= "action/login_success";
		public static const LOGIN_FAILED:String				= "action/login_failed";
		
		public static const FAILING:String  	  		  = "state/failing";
		public static const FAIL:String  	  		  	  = "note/fail";
		
		
		/************************************
		 * HOST ADDRESS
		 * **********************************/
		public static const HOST_URL:String = ShellFacade.DEBUG_MODE == true ? DEBUG_HOST : RELEASE_HOST;
		public static const DEBUG_HOST:String = "http://localhost:8000";
		public static const RELEASE_HOST:String = "http://captionapp.appspot.com";
		

		/************************************
		 * Module Addresses & Names 
		 * **********************************/
		

		
		public static const ADD_MODULE:String = "note/add/module";
		public static const MODULE_ADDED:String = "note/module/added";
				
		//Creator
		public static const CREATOR_ADDED:String = "note/creator/added";
		public static const CREATOR_NAME:String = "Creator";
		public static const LOAD_CREATOR:String = "note/load/creator";
		public static const REMOVE_CREATOR:String = "note/remove/creator";
		public static const CREATOR_MODULE_URL:String = HOST_URL+CREATOR_DIRECTORY;
															/*HOST_URL+
															ShellFacade.DEBUG_MODE == true ? 
															"/client/captionmashup/development/Creator.swf" :
															"/client/captionmashup/release/Creator.swf";*/
	
		private static function get CREATOR_DIRECTORY():String{
			if(ShellFacade.DEBUG_MODE == true){
				return CREATOR_DEVELOPMENT;
			}else{
				return CREATOR_PRODUCTION;
			}
		} 
		
		private static const CREATOR_DEVELOPMENT:String = "/client/captionmash/development/Creator.swf";
		private static const CREATOR_PRODUCTION:String = "/client/captionmash/production/Creator.swf";

		//Facebook
		public static const FACEBOOK_NAME:String = "Facebook";
		public static const LOAD_FACEBOOK:String = "note/load/facebook";
		public static const FACEBOOK_MODULE_URL:String = HOST_URL+"/client/captionmash/development/Facebook.swf";//HOST_URL + FACEBOOK_ACTIVE ;
		
		private static const FACEBOOK_ACTIVE:String 	= ShellFacade.DEBUG_MODE == true ? FACEBOOK_DEBUG : FACEBOOK_RELEASE;
		private static const FACEBOOK_DEBUG:String 		= "/client/captionmash/development/Facebook.swf";
		private static const FACEBOOK_RELEASE:String	= "/client/captionmash/release/Facebook.swf"; 

		
		public static const LOAD_FLICKR:String = "note/load/flickr";
		public static const FLICKR_MODULE_URL:String = "Flickr.swf";
		public static const FLICKR_NAME:String = "Flickr";
		

	}
}