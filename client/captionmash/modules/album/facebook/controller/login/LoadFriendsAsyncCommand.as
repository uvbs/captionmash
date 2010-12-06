package com.captionmashup.modules.album.facebook.controller.login
{
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.modules.album.facebook.model.dto.Friend;
	import com.captionmashup.modules.album.facebook.model.proxy.FriendProxy;
	import com.captionmashup.modules.album.facebook.model.proxy.PhotoProxy;
	import com.captionmashup.modules.album.facebook.model.proxy.UserProxy;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.AsyncCommand;
	
	import sk.yoz.events.FacebookOAuthGraphEvent;
	
	import com.captionmashup.common.log.t;

	public class LoadFriendsAsyncCommand extends AsyncCommand
	{
		private var accountProxy:UserProxy;
		private var photoProxy:PhotoProxy;
		private var friendProxy:FriendProxy;
		
		private var friendCollection:ArrayCollection;
		
		override public function execute ( note:INotification ) : void
		{
			trace("LoadFriendsAsyncCommand called");
			accountProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			friendProxy = facade.retrieveProxy(FriendProxy.NAME) as FriendProxy;
			
			friendProxy.loadFriends(onLoadFriends);
			//photoProxy.loadAlbums(accountProxy.user);
		}
		
		//Sets paginator using the returned friends list from Social Network API
		private function onLoadFriends(evt:FacebookOAuthGraphEvent):void{
			
			friendProxy = facade.retrieveProxy(FriendProxy.NAME) as FriendProxy;
			//t.obj(evt.data,"evt.data LoadFriendsAsyncCommand.onLoadFriends");
			
			var temp:Array = handleFriendData(evt); 		
			//Unsorted friends collection is sent to paginator with Sort field = name
			friendProxy.setPaginator(temp,ApplicationConstants.FRIEND_PAGINATOR_PAGE_SIZE,"name",false);
			
			//Add friends layer to photoProxy
			photoProxy = facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;
			//photoProxy.addFriends(friendProxy.allRecords());
			
			commandComplete();
		}
		
		private function  handleFriendData(obj:Object):Array{
			
			var sourceData:Array = obj.data.data as Array;
			var result:Array= new Array();

			for each ( var obj:Object in sourceData){
				var friend:Friend = new Friend(obj);
				result.push(friend);
			}
			return result;
		}

	}
}