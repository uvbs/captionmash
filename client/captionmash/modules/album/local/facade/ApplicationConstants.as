package com.captionmashup.modules.album.local.facade
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
		
		//UI Query
		public static const UI_QUERY:String = "note/ui_query";
		
		/**************************************
		 * BATCH PHOTO ADDITION Notifications
		 * *************************************/
		public static const ADD_ALL_PHOTOS_TO_BASKET:String = "note/add_all_photos_to_basket";
		public static const CAPTION_ALL_PHOTOS:String = "note/caption_all_photos";
		
		/*******************************
		 * UI STATE Notifications
		 * *****************************/
		public static const SWITCH_GENRE_STATE:String	= "note/switch_genre_state";
		public static const SWITCH_MEMBER_STATE:String	= "note/switch_member_state";
		public static const SWITCH_ALBUM_STATE:String	= "note/switch_album_state";
		public static const SWITCH_PHOTO_STATE:String	= "note/switch_photo_state";
		
		/******************************
		 * Service Call Notifications
		 * ****************************/
		public static const LIST_GENRES:String 			= "note/list_genres";
		public static const LIST_MEMBERS:String 		= "note/list_members";
		public static const LIST_GENRE_ALBUMS:String	= "note/list_genre_albums";
		public static const LIST_USER_ALBUMS:String		= "note/list_user_albums";
		public static const LIST_PHOTOS:String			= "note/list_photos";
		
		/*****************************
		 * Paginator notifications
		 * *****************************/
		public static const GENRE_PAGINATOR_NOTIFICATION:String 	= "note/genre_paginator_notification";
		public static const ALBUM_PAGINATOR_NOTIFICATION:String		= "note/album_paginator_notification";
		public static const PHOTO_PAGINATOR_NOTIFICATION:String		= "note/photo_paginator_notification";
		public static const MEMBER_PAGINATOR_NOTIFICATION:String	= "member/photo_paginator_notification";
		/******************************
		 * Paginator Size Constants
		 * ***************************/
		//VIEW COMPONENT CONSTANTS
		
		//Genre list
		public static const GENRE_LIST_COLUMN_COUNT:int = 4;
		public static const GENRE_LIST_ROW_COUNT:int = 3;
		
		public static function get GENRE_LIST_PAGE_SIZE():int{
			return GENRE_LIST_ROW_COUNT * GENRE_LIST_COLUMN_COUNT;
		}
		
		//Genre list
		public static const MEMBER_LIST_COLUMN_COUNT:int = 4;
		public static const MEMBER_LIST_ROW_COUNT:int = 2;
		
		public static function get MEMBER_LIST_PAGE_SIZE():int{
			return MEMBER_LIST_ROW_COUNT * MEMBER_LIST_COLUMN_COUNT;
		}
		
		//Album list
		public static const ALBUM_LIST_COLUMN_COUNT:int = 5;
		public static const ALBUM_LIST_ROW_COUNT:int = 3;
		
		public static function get ALBUM_LIST_PAGE_SIZE():int{
			return ALBUM_LIST_ROW_COUNT * ALBUM_LIST_COLUMN_COUNT;
		}
		
		//Photo List
		public static const PHOTO_LIST_COLUMN_COUNT:int = 4;
		public static const PHOTO_LIST_ROW_COUNT:int = 4;
		
		public static function get PHOTO_LIST_PAGE_SIZE():int{
			return PHOTO_LIST_ROW_COUNT * PHOTO_LIST_COLUMN_COUNT;
		}
	}
}