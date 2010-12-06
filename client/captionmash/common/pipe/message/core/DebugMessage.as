package com.captionmashup.common.pipe.message.core
{
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	/*****************************************
	 * Messaging Protocol between shell and
	 * debug module
	 * ***************************************/
	public class DebugMessage extends Message
	{
		protected static const NAME:String = 'DebugMessage';
		
		public static const SHOW:String 	= NAME + '/message/show'; //shell=>module
		public static const HIDE:String 	= NAME + '/message/hide'; //shell=>module
		public static const LOG:String 		= NAME + '/message/log'; //shell=>module
		public static const TEST_PIPE:String = NAME + '/message/test_pipe'; //module => shell
		
		public function DebugMessage(type:String,header:Object=null,body:Object=null)
		{
			trace("DebugMessage set with type: "+type+" header: "+header+" body: "+body);
			super(type,header,body);
		}
	}
}