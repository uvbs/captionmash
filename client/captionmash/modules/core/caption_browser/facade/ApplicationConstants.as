package com.captionmashup.modules.core.caption_browser.facade
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

		public static const LATEST_CAPTIONS:String					= "note/latest_captions";
		
		public static const CAPTION_PAGINATOR_NOTIFICATION:String 	= "note/caption_paginator_notification";
		
		//UI Notifications
		public static const UI_QUERY:String	 = "note/ui_query";
		
		//VIEW COMPONENT CONSTANTS
		public static const CAPTION_THUMB_LIST_COLUMN_COUNT:int = 5;
		public static const CAPTION_THUMB_LIST_ROW_COUNT:int = 3;
		
		public static function get CAPTION_LIST_PAGE_SIZE():int{
			return CAPTION_THUMB_LIST_ROW_COUNT * CAPTION_THUMB_LIST_COLUMN_COUNT;
		}
	}
}