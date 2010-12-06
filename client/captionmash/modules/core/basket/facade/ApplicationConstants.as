package com.captionmashup.modules.core.basket.facade
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
		
		public static const ADD_PHOTO:String 		= "note/add_photo";
		
		public static const ADD_OBJECT:String	= "note/add_object";
		
		public static const REMOVE_PHOTO:String 	= "note/remove_photo";
		public static const REMOVE_OBJECT:String 	= "note/remove_object";
		
		//Paginator notifications
		
		public static const PHOTO_PAGINATOR_NOTIFICATION:String 	= "note/photo_paginator";
		public static const OBJECT_PAGINATOR_NOTIFICATION:String 	= "note/object_paginator";
		
		//View component constants
		public static const PHOTO_BASKET_COLUMN_COUNT:int	=	3;
		public static const PHOTO_BASKET_ROW_COUNT:int		=	2;
	}
}