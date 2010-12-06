package com.captionmashup.modules.album.facebook.facade
{
	import com.captionmashup.common.CommonConstants;

	public class ApplicationConstants
	{
		public function ApplicationConstants()
		{
		}
		
		/*************************************
		 * NOTIFICATIONS
		 * ***********************************/
		
		//UI_QUERY
		public static const UI_QUERY:String			= "note/ui_query";
		
		//Command Call notifications
		public static const LOAD_ALBUMS:String 				= "note/load_albums";
		public static const LOAD_PHOTOS:String 				= "note/load_photos";
		public static const CREATE_ALBUM_POPUP:String 		= "note/create_album_popup";
		public static const CREATE_PHOTO_POPUP:String 		= "note/create_photo_popup";
		public static const START_CREATE:String				= "note/start_create";
		public static const ADD_TO_BASKET:String			= "note/add_to_basket";
		
		//Shell Communication
		public static const SEND_MESSAGE_TO_SHELL:String 	= 'note/send_message_to_shell';
		
		//Facebook Login
		public static const TRY_LOGIN:String 			= "note/try_login";
		public static const LOGIN_SUCCESS:String 		= "note/login_success";
		public static const LOGIN_FAIL:String 			= "note/login_fail";
		
		public static const LOAD_PROFILE:String 		= "note/load_profile";
		public static const LOAD_USER_DATA:String 		= "note/load_user_data";

		//Paginator
		public static const FRIEND_PAGINATOR_NOTIFICATION:String = "note/friend_paginator_notification";
		public static const PHOTO_PAGINATOR_NOTIFICATION:String = "note/photo_paginator_notification";
		public static const ALBUM_PAGINATOR_NOTIFICATION:String = "note/album_paginator_notification";
	
		/*********************************
		 * FACEBOOK DATA
		 * *****************************/
		//FACEBOOK APPLICATION VALUES
		
		public static const NETWORK_NAME:String = CommonConstants.FACEBOOK_NETWORK_NAME;
		public static const CLIENT_ID:String ="130959613585206";
		[Bindable]public static var CAPTION_URL:String = ApplicationFacade.DEBUG_MODE ? DEBUG_CAPTION_URL : DEPLOY_CAPTION_URL;//binded for caption url  
		
		
		public static const DEBUG_CAPTION_URL:String = "http://localhost:8000/caption/";
		public static const DEPLOY_CAPTION_URL:String = "http://apps.facebook.com/captionmashup/caption/";
		
		public static const REDIRECT_URI:String = CommonConstants.FACEBOOK_REDIRECT_URI;
		//local test
		public static const DEBUG_URI:String = CommonConstants.FACEBOOK_DEBUG_URI;
		//facebook connect
		public static const DEPLOY_URI:String = CommonConstants.FACEBOOK_DEPLOY_URI;
		
		public static const PERMISSION_SCOPE:String = CommonConstants.FACEBOOK_PERMISSION_SCOPE;;
	
		/***************************
		 * GRAPH API CALL CONSTANTS
		 * *************************/
		public static const ME:String = "me";
		public static const ME_FRIENDS:String = "me/friends";
		public static const ME_ALBUMS:String = "me/albums";
		public static const PHOTOS:String = "/photos";
		public static const ALBUMS:String = "/albums";
		
		
		/****************************
		 * PROXY CONSTANTS
		 * *************************/
		public static const FRIEND_PAGINATOR_PAGE_SIZE:int = 15;
		
		public static const PHOTO_PAGE_ROW_SIZE:int = 3;
		public static const PHOTO_PAGE_COLUMN_SIZE:int = 3;
		public static function get PHOTO_PAGINATOR_PAGE_SIZE():int{
			return PHOTO_PAGE_ROW_SIZE * PHOTO_PAGE_COLUMN_SIZE;
		}
		
		public static const ALBUM_PAGE_ROW_SIZE:int = 2;
		public static const ALBUM_PAGE_COLUMN_SIZE:int = 3;
		public static function get ALBUM_PAGINATOR_PAGE_SIZE():int{
			return ALBUM_PAGE_ROW_SIZE * ALBUM_PAGE_COLUMN_SIZE;
		}
		
	}
}