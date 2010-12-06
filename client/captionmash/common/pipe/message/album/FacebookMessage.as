package com.captionmashup.common.pipe.message.album
{
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	/*****************************************
	 * Messaging Protocol for Facebook module
	 * interaction
	 * ***************************************/
	
	public class FacebookMessage extends Message
	{
		protected static const NAME:String = 'FacebookMessage ';
		
		public static const LOAD_MODULE:String 	= NAME + '/message/load_module'; 
		public static const GET_UI:String 		= NAME + '/message/get_ui'; //shell=>module
		public static const SET_UI:String 		= NAME + '/message/set_ui'; //module=>shell
				
		public function FacebookMessage(type:String, body:Object=null)
		{
			super(type, null, body);
		}
	}
}