package com.captionmashup.modules.core.viewer.facade
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
		
		public static const START_VIEW:String 	= "note/start_view";
		public static const STOP_VIEW:String 	= "note/stop_view";
		public static const GET_CAPTION:String = "note/get_caption";
		
		public static const FRAMES_SET:String		= "note/frames_set";
		public static const FRAME_CHANGED:String	= "note/frame_changed";
		
		//Basket Notification
		public static const ADD_TO_BASKET:String	= "note/add_to_basket";
		
		//Creator Notification
		public static const START_CREATE:String		= "note/start_create";
		
	}
}