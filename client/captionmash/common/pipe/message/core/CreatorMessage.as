package com.captionmashup.common.pipe.message.core
{
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	/*****************************************
	 * Messaging Protocol between shell and
	 * creator module
	 * ***************************************/
	public class CreatorMessage extends Message
	{
		protected static const NAME:String = 'CreatorMessage';
		
		//Types
		public static const START_CREATE:String 	= NAME + '/message/start_create'; //shell=>module
		public static const END_CREATE:String 		= NAME + '/message/end_create'; //module=>shell	
		
		public static const GET_UI:String 		= NAME + '/message/get_ui'; //shell=>module	
		public static const SET_UI:String 		= NAME + '/message/set_ui'; //module=>shell
		
		//Headers
		public static const HEADER_PHOTO_LINK:String		= NAME+'/header/photo_link';
		public static const HEADER_ALBUM_LINK:String		= NAME+'/header/album_link';
		public static const HEADER_TEMPLATE_LINK:String		= NAME+'/header/template_link';
		
		public function CreatorMessage(type:String, body:Object=null,header:Object = null)
		{
			super(type, header, body);
		}
		
	}
}