package com.captionmashup.common.pipe.message.core
{
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class UploadMessage extends Message
	{
		protected static const NAME:String = 'UploadMessage';
		
		public static const UPLOAD_TO_DJANGO:String	= NAME + '/message/upload_to_django'; //shell=>module
		public static const SHOW:String				= NAME + '/message/show'; 
		public static const SELECT_FILE:String		= NAME + '/message/select_file'; 
		
		public function UploadMessage(type:String, header:Object=null, body:Object=null, priority:int=5)
		{
			super(type, header, body, priority);
		}
	}
}