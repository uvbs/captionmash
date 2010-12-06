package com.captionmashup.common.pipe.message.core
{
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	/*****************************************
	 * Messaging Protocol for creating and
	 * removing popups
	 * ***************************************/
	
	public class PopupMessage extends Message
	{
		protected static const NAME:String = 'PopupMessage';
		
		public static const CREATE_POPUP:String = NAME + '/message/CREATE_POPUP'; 
		public static const CREATE_MODAL_POPUP:String = NAME + '/message/CREATE_MODAL_POPUP'; 
		public static const REMOVE_POPUP:String = NAME + '/message/REMOVE_POPUP'; 

	
		public function PopupMessage(type:String, activeContent:Object=null)
		{
			super(type, null, activeContent);
		}
		
		public function get activeContent():Object
		{
			return body as Object;
		}
	}
}