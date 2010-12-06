package com.captionmashup.modules.core.album_manager.facade
{
	import com.captionmashup.common.CommonConstants;

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
		
		public static function get DJANGO_UPLOAD_URL():String{
			if(CommonConstants.DEBUG_MODE == true){
				return DEBUG_UPLOAD_URL;				
			}else{
				return DEPLOY_UPLOAD_URL;
			}
		}
		
		public static const DEBUG_UPLOAD_URL:String = "http://localhost:8000/upload/";
		public static const DEPLOY_UPLOAD_URL:String = "http://captionapp.appspot.com/upload/";
		public static const IMAGE_SIZE_LIMIT:int		= 800000;
		
		//Login / Logout
		public static const USER_LOGIN:String		= "note/user_login";
		public static const USER_LOGOUT:String		= "note/user_logout";
		
		//Notifications
		public static const CLOSE_MANAGER:String		= "note/close_manager";
		
		//Photos
		public static const UPLOAD_TO_ALBUM:String		= "note/upload_to_album";
		public static const DELETE_PHOTO:String			= "note/delete_photo";
		public static const SAVE_PHOTO:String			= "note/save_photo";
		public static const SAVE_PHOTO_SUCCESS:String	= "note/save_photo_success";
		public static const SAVE_PHOTO_FAIL:String		= "note/save_photo_fail";
		
		//Albums
		public static const GET_USER_ALBUMS:String		= "note/get_user_albums";
		public static const GET_ALBUM_PHOTOS:String		= "note/get_album_photos";
		public static const CREATE_ALBUM:String			= "note/create_album";
		public static const DELETE_ALBUM:String			= "note/delete_album";
		
		//Index change notifications (Used to refresh popups)
		public static const ALBUM_INDEX_CHANGED:String	= "note/album_index_changed";
		public static const PHOTO_INDEX_CHANGED:String	= "note/photo_index_changed";
		
		//Upload Progress
		public static const UPLOAD_STARTED:String			= "note/upload_started";
		public static const UPLOAD_SIZE_ERROR:String		= "note/upload_size_error";
		public static const UPLOAD_FINISHED:String			= "note/upload_finished";
		public static const UPLOAD_FAILED:String			= "note/upload_failed";
		
		//Creator
		public static const START_CREATE:String				= "note/start_create";
		
		//Paginator
		public static const ALBUM_PAGINATOR_NOTIFICATION:String	 = "note/album_paginator_notification";
		public static const PHOTO_PAGINATOR_NOTIFICATION:String	 = "note/photo_paginator_notification";
		/********************************
		 * View Component Constants
		 * ******************************/
		public static const ALBUM_THUMB_LIST_ROW_COUNT:int 	= 1;
		public static const ALBUM_THUMB_LIST_COLUMN_COUNT:int 	= 4;
		public static function get ALBUM_PAGINATOR_PAGE_SIZE():int{
			return ALBUM_THUMB_LIST_ROW_COUNT * ALBUM_THUMB_LIST_COLUMN_COUNT;
		}
		
		public static const PHOTO_THUMB_LIST_ROW_COUNT:int 	= 2;
		public static const PHOTO_THUMB_LIST_COLUMN_COUNT:int 	= 3;
		public static function get PHOTO_PAGINATOR_PAGE_SIZE():int{
			return PHOTO_THUMB_LIST_ROW_COUNT * PHOTO_THUMB_LIST_COLUMN_COUNT;
		}
		
	}
}