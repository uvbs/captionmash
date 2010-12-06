package com.captionmashup.modules.core.login.facade
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
		
		//UI Notifications
		public static const UI_QUERY:String	 			= "note/ui_query";
		public static const POPUP_LOGIN:String 			= "note/popup_login";
		public static const POPUP_REGISTRATION:String 	= "note/popup_registration";
		
		//Notifications
		public static const LOGIN:String			= "note/login";
		public static const LOGOUT:String			= "note/logout";
		
		//Used when login successful or already logged in user is found
		public static const USER_RETRIEVED:String	= "note/user_retrieved";
		public static const LOGOUT_COMPLETE:String	= "note/logout_complete";
		
		//Registration notifications
		public static const CHECK_UNIQUE_EMAIL:String 	= "note/check_unique_email";
		public static const EMAIL_UNIQUE:String			= "note/email_unique";
		public static const EMAIL_NOT_UNIQUE:String		= "note/email_not_unique";
		
		public static const CHECK_UNIQUE_NICKNAME:String	= "note/check_unique_nickname";
		public static const NICKNAME_UNIQUE:String			= "note/nickname_unique";
		public static const NICKNAME_NOT_UNIQUE:String		= "note/nickname_not_unique";
	
		public static const CREATE_USER:String	= "note/create_user";
	}
}