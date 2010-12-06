package com.captionmashup.common
{
	public class CommonConstants
	{
		public function CommonConstants()
		{
		}
		
		public static const DEBUG_MODE:Boolean = true;
		
		
		/************************************
		 * HOST ADDRESS
		 * **********************************/
		public static const HOST_URL:String = DEBUG_MODE == true ? DEBUG_HOST : RELEASE_HOST;
		public static const DEBUG_HOST:String = "http://localhost:8000";
		public static const RELEASE_HOST:String = "http://captionapp.appspot.com";
		public static const HOMEPAGE:String = DEBUG_MODE == true ? DEBUG_HOST : "http://captionmash.com";
		
		/*************************************
		 * DOMAIN CONSTANTS
		 * **********************************/
		public static function get gatewayURL():String{
			if(DEBUG_MODE){
				return debugURL;
			}else{
				return deployURL;
			}
		}
		public static var debugURL:String = "http://localhost:8000/gateway/"
		public static var deployURL:String = "http://captionapp.appspot.com/gateway/"
		/*************************************
		 * VIEW COMPONENT SIZE CONSTANTS
		 * **********************************/
		
		public static const CAPTION_CANVAS_HEIGHT:int = 600;
		public static const CAPTION_CANVAS_WIDTH:int = 960;
		
		public static const VERTICAL_SCROLL_DUCT_TAPE_HEIGHT:int = 20000;
		//If an image is taller than this value the canvas will be scaled vertically
		public static const CAPTION_CANVAS_HEIGHT_SCALE_LIMIT:int = 960;
		
		/*****************************************
		 * FACEBOOK CONSTANTS
		 * **************************************/
		
		//FACEBOOK APPLICATION VALUES
		public static const FACEBOOK_NETWORK_NAME:String	 = "facebook";
		public static const FACEBOOK_CLIENT_ID:String		 ="130959613585206";
		
		public static const FACEBOOK_REDIRECT_URI:String	 = DEBUG_MODE ? FACEBOOK_DEBUG_URI : FACEBOOK_DEPLOY_URI;
		public static const FACEBOOK_MODULE_URL:String		 = DEBUG_MODE ? FACEBOOK_MODULE_DEBUG_URL : FACEBOOK_MODULE_DEPLOY_URL;
		//local test
		public static const FACEBOOK_DEBUG_URI:String		 = "http://localhost:8000/client/callback.html";
		//facebook connect
		public static const FACEBOOK_DEPLOY_URI:String		 = "http://www.captionmashup.com/client/callback.html";
		public static const FACEBOOK_PERMISSION_SCOPE:String = "publish_stream,user_photos,user_photo_video_tags,friends_photo_video_tags,friends_photos";
		
		public static const FACEBOOK_MODULE_DEBUG_URL:String  = "http://localhost:8000/client/captionmash/development/Facebook.swf";
		public static const FACEBOOK_MODULE_DEPLOY_URL:String = HOST_URL+"/client/captionmash/release/Facebook.swf";	
	

	}
}