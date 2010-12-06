package com.captionmashup.modules.album.facebook.view
{
	import com.captionmashup.common.model.proxy.PaginatorProxy.IPaginatorProxy;
	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.view.component.FriendsList.FriendsList;
	import com.captionmashup.common.view.mediator.SearchboxPaginatorMediator;
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.modules.album.facebook.model.dto.Friend;
	import com.captionmashup.common.model.foreign.facebook.User;
	import com.captionmashup.modules.album.facebook.model.proxy.FriendProxy;
	import com.captionmashup.modules.album.facebook.model.proxy.UserProxy;
	
	import flash.events.MouseEvent;
	
	import mx.events.ListEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class FriendMediator extends SearchboxPaginatorMediator
	{
		public static const NAME:String = "FriendMediator";
		
		public function FriendMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			friends.list.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,onFriendDoubleClick);
			friends.myAlbumsButton.addEventListener(MouseEvent.CLICK,onMyAlbumsButton);
		}
		
		public function get friends():FriendsList{
			return viewComponent as FriendsList;
		}
		
		override public function onRegister():void{
			paginatorProxy = facade.retrieveProxy(FriendProxy.NAME) as IPaginatorProxy;
		}
		
		/**********************************************
		 * VIEW COMPONENT HANDLERS
		 * ******************************************/
		//Album Selection
		private function onFriendDoubleClick(evt:ListEvent):void{
			trace("onFriendDoubleClick called");
			paginatorProxy.activeContent = evt.itemRenderer.data;
			sendNotification(ApplicationConstants.LOAD_ALBUMS,evt.itemRenderer.data as Friend);
			//sendNotification(ApplicationFacade.LOAD_ALBUMS,evt.itemRenderer.data as Friend);
		}
		
		private function onMyAlbumsButton(evt:MouseEvent):void{
			trace("onMyAlbumsButton called");
			paginatorProxy.activeContent = null; //Set active album owner to null, 
												 //so User is used for both owner and author
			var userProxy:UserProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			sendNotification(ApplicationConstants.LOAD_ALBUMS,userProxy.user as User);
			//sendNotification(ApplicationFacade.LOAD_ALBUMS,ApplicationFacade.user as AppAccount);
		}
		
		/**********************************************
		 * NOTIFICATION HANDLERS
		 * ********************************************/
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.FRIEND_PAGINATOR_NOTIFICATION,

			];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{	
				case ApplicationConstants.FRIEND_PAGINATOR_NOTIFICATION:			
					updateView(note.getBody() as PaginatorData,friends.list);
					break;
			}
		}//handleNotification end
	}
}