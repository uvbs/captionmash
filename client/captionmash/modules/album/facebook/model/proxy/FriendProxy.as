package com.captionmashup.modules.album.facebook.model.proxy
{	
	import com.captionmashup.common.model.proxy.PaginatorProxy.AbstractPaginatorProxy;
	import com.captionmashup.common.model.local.paginator.PaginatorEvent;

	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.common.model.gateway.FacebookGraphGateway;
	
	import mx.collections.ArrayCollection;
	
	
	import sk.yoz.events.FacebookOAuthGraphEvent;

	/***************************************
	 * Proxy class used to retrieve and store
	 * Friends from Facebook
	 * *************************************/
	public class FriendProxy extends AbstractPaginatorProxy
	{
		public static const NAME:String = 'FriendProxy';
		
		public function FriendProxy()
		{
			super(NAME);	
		}
		
		//Loads friends from social network API
		public function loadFriends(callback:Function):void{
			trace("friendsProxy loadfriends called");
			FacebookGraphGateway.call(ApplicationConstants.ME_FRIENDS,false,callback);
		}
	
		//paginator notification handlers
		override public function pageHandler(evt:PaginatorEvent):void{
			sendNotification(ApplicationConstants.FRIEND_PAGINATOR_NOTIFICATION,evt.data);
		}

	}
}