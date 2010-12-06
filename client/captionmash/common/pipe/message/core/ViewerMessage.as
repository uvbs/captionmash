package com.captionmashup.common.pipe.message.core
{
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;

	public class ViewerMessage extends Message
	{
		protected static const NAME:String = 'ViewerMessage';
		
		public static const START_VIEW:String 	= NAME + '/message/start_view'; //shell=>module
		public static const END_VIEW:String 	= NAME + '/message/end_view'; //module=>shell	
		public static const GET_CAPTION:String	= NAME + '/message/get_caption'//shell=>module
		
		public function ViewerMessage(type:String, obj:Object = null)
		{
			super(type,null,obj);
		}
	}
}