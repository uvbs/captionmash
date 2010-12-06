package com.captionmashup.modules.core.creator.facade
{
	public class ApplicationConstants
	{
		public function ApplicationConstants()
		{
		}
		
		//UI Notifications
		public static const UI_QUERY:String	 = "note/ui_query";
		
		
		//Module
		public static const STARTUP:String = 'startup';
		public static const MESSAGE_FROM_SHELL_RECEIVED:String = 'note/message_from_shell_received"';
		public static const SEND_MESSAGE_TO_SHELL:String = 'note/send_message_to_shell';
		public static const DISPOSE:String = 'note/dispose';	
		
		
		//Caption Creation
		public static const START_CREATION:String 	= "note/start_create";
		public static const CANCEL_CREATION:String 	= "note/cancel_create";
		public static const POST_CREATION:String	= "note/post_create";
		public static const POST_SUCCESSFUL:String	= "note/post_successful";
		
		//Photo Retrieval
		public static const GET_SINGLE_PHOTO:String 	= "note/get_single_photo";
		public static const GET_ALBUM_PHOTOS:String		= "note/get_album_photos";
		public static const GET_TEMPLATE_PHOTOS:String	= "note/get_template_photos";
	
		//Frame Notifications
		public static const ADD_FRAME:String	= "note/add_frame";
		public static const SAVE_FRAME:String	= "note/save_frame";
		public static const DELETE_FRAME:String	= "note/delete_frame";
		public static const SWAP_FRAME:String 	= "note/swap_frame";
		public static const FRAMES_EMTPY:String	= "note/frames_empty";
		public static const CLEAR_FRAMES:String	= "note/clear_frames";
		
		//Caption Player 
		public static const START_PLAY:String		= "note/start_play";
		public static const STOP_PLAY:String		= "note/stop_play";
		
		
		//Paginator notifications
		public static const FRAMES_SET:String 		="note/frames_set";
		public static const FRAME_CHANGED:String 	="note/frame_changed";
	}
}