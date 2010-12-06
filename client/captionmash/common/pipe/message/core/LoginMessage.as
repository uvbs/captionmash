package com.captionmashup.common.pipe.message.core
{
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class LoginMessage extends Message
	{
		protected static const NAME:String = 'LoginMessage';
		
		public static const TRY_LOGIN:String 		= NAME + '/message/try_login'; //shell=>module
		public static const CANCEL:String 			= NAME + '/message/cancel'; //module=>shell	
		public static const REGISTER:String			= NAME + '/message/register';
		
		public static const GET_USER_DATA:String	= NAME + '/message/get_user_data';
		public static const SET_USER_DATA:String	= NAME + '/message/set_user_data'
			
		public static const GET_UI:String	= NAME + '/message/get_ui';
		public static const SET_UI:String	= NAME + '/message/set_ui';
		
		public function LoginMessage(type:String, body:Object = null)
		{
			super(type,null,body);
		}
	}
}