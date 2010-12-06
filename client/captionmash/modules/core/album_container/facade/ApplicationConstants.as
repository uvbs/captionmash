package com.captionmashup.modules.core.album_container.facade
{
	public class ApplicationConstants
	{
		public function ApplicationConstants()
		{
		}
		//Module
		public static const STARTUP:String = 'startup';
		public static const MESSAGE_FROM_SHELL_RECEIVED:String = 'note/message_from_shell_received"';
		public static const SEND_MESSAGE_TO_SHELL:String = 'note/send_message_to_shell';
		public static const DISPOSE:String = 'note/dispose';	
		
		
		public static const BROWSE_IMAGES:String	= "note/browse_images";
		
		/******************************
		 * Login Notifications
		 * *******************************/
		public static const USER_LOGIN:String 	= "note/user_login";
		public static const USER_LOGOUT:String 	= "note/user_logout";
		
		/******************************
		 * Service Call Notifications
		 * ****************************/
		public static const LIST_LATEST_CAPTIONED_PHOTOS:String	= "note/list_latest_captioned_photos";
		public static const LIST_LATEST_ADDED_PHOTOS:String	= "note/list_latest_added_photos";
		
		/*****************************
		 * Paginator notifications
		 * *****************************/
		public static const PHOTO_PAGINATOR_NOTIFICATION:String		= "note/photo_paginator_notification";
		
		/****************************
		 * UI NOTIFICATIONS
		 * **************************/
		//Native UI Notifications
		public static const UI_QUERY:String				 	= "note/ui_query"; 
		
		//Local albums
		public static const SET_LOCAL_ALBUM_BROWSER_UI:String 	= "note/set_local_album_browser_ui";
	
		//Facebook
		public static const GET_FACEOOK_UI:String	= "note/get_facebook_ui";
		public static const SET_FACEBOOK_UI:String	= "note/set_facebook_ui";
		
		//Photo List
		public static const PHOTO_LIST_COLUMN_COUNT:int = 4;
		public static const PHOTO_LIST_ROW_COUNT:int = 4;
		
		public static function get PHOTO_LIST_PAGE_SIZE():int{
			return PHOTO_LIST_ROW_COUNT * PHOTO_LIST_COLUMN_COUNT;
		}
	}
}