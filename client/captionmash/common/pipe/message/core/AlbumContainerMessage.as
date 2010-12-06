package com.captionmashup.common.pipe.message.core
{
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	/***********************************
	 * Album Container Message
	 * 
	 * Includes commands for switching
	 * album browsers
	 * *********************************/
	
	public class AlbumContainerMessage extends Message
	{
		protected static const NAME:String  = 'AlbumContainerMessage';
		
		public static const SET_UI:String	= 	NAME+"/message/set_ui";
		public static const GET_UI:String	= 	NAME+"/message/get_ui";
		
		public function AlbumContainerMessage(type:String, body:Object=null)
		{
			super(type, null, body);
		}
	}
}