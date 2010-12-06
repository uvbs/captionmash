package com.captionmashup.common.pipe.message.core
{
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	/***********************************
	 * NavigationMessage
	 * 
	 * Includes commands for switching
	 * user interface states/panels etc
	 * *********************************/
	public class NavigationMessage extends Message
	{
		protected static const NAME:String = 'NavigationMessage';
		
		public static const ALBUM_HOME:String	= 	NAME+"/message/album_home";
		
		public static const BROWSE_ALBUMS:String	= 	NAME+"/message/browse_albums";
		public static const BROWSE_CAPTIONS:String	= 	NAME+"/message/browse_albums";
		
		public function NavigationMessage(type:String, body:Object=null)
		{
			super(type, null, body);
		}
	}
}