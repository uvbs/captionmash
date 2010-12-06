package com.captionmashup.common.pipe.message.core
{
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class CaptionBrowserMessage extends Message
	{
		
		protected static const NAME:String = 'CaptionBrowserMessage';
		
		public static const GET_UI:String 	= NAME + '/message/get_ui'; //shell=>module
		public static const SET_UI:String 	= NAME + '/message/set_ui'; //module=>shell
		
		public static const LATEST_CAPTIONS:String 	= NAME+'/message/latest_captions';
		public static const USER_CAPTIONS:String   	= NAME+'/message/user_captions';
		public static const ALBUM_CAPTIONS:String   = NAME+'/message/album_captions';
				
		public function CaptionBrowserMessage(type:String,body:Object=null,header:Object=null)
		{
			super(type, header, body);
		}
	}
}