package com.captionmashup.common.pipe.message.album
{
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	/*****************************************
	 * Messaging Protocol for LocalAlbumModule
	 * interaction
	 * ***************************************/
	
	public class LocalAlbumMessage extends Message
	{
		protected static const NAME:String = 'LocalAlbumMessage';
		
		public static const GET_UI:String 	= NAME + '/message/get_ui'; //shell=>module
		public static const SET_UI:String 	= NAME + '/message/set_ui'; //module=>shell
		
		public static const LIST_GENRES:String 			= NAME + '/message/list_genres';
		public static const LIST_MEMBERS:String 		= NAME + '/message/list_members'
		public static const LIST_USER_ALBUMS:String 	= NAME + '/message/list_user_albums';
		public static const LIST_GENRE_ALBUMS:String 	= NAME + '/message/list_genre_albums';
		public static const LIST_PHOTOS:String 			= NAME + '/message/list_photos';
		
		public function LocalAlbumMessage(type:String, body:Object=null)
		{
			super(type, null, body);
		}
	}
}