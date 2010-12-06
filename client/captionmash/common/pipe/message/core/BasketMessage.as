package com.captionmashup.common.pipe.message.core
{
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class BasketMessage extends Message
	{
	
		protected static const NAME:String = 'BasketMessage';
		
		public static const ADD_PHOTO:String 		= NAME + '/message/add_photo'; //shell=>module	
		public static const ADD_OBJECT:String 	= NAME + '/message/add_object'; //shell=>module
		public static const REMOVE:String 		= NAME + '/message/cancel'; //shell=>module
		
		public static const SHOW:String 		= NAME + '/message/show'; //shell=>module
		public static const HIDE:String 		= NAME + '/message/hide'; //shell=>module
		public static const TOGGLE:String		= NAME + '/message/toggle';
		
		//Body must be either PhotoDTO, ObjectDTO or FilterDTO(?)
		//Basket name must be included in header
		public function BasketMessage(type:String, body:Object=null)
		{
			super(type, null, body);
		}
	}
}