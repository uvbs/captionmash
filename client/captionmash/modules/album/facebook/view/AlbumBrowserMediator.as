package com.captionmashup.modules.album.facebook.view
{

	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.view.component.FriendsList.FriendsList;
	import com.captionmashup.common.view.component.Paginator.Paginator_Component;
	
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.modules.album.facebook.model.proxy.FriendProxy;
	import com.captionmashup.modules.album.facebook.view.components.AlbumBrowser.AlbumBrowser;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.events.ListEvent;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class AlbumBrowserMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'AlbumBrowserMediator';
		
		private var friendProxy:FriendProxy;
		
		private var dataProvider:ArrayCollection;
		private var paginatorData:PaginatorData;
		
		public function AlbumBrowserMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			//Friends list listeners
			friends.list.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,onFriendDoubleClick);
			friends.myAlbumsButton.addEventListener(MouseEvent.CLICK,onMyAlbumsButton);
			friends.addEventListener(FriendsList.FRIEND_SEARCH_START,onSearchStart);
			friends.addEventListener(FriendsList.FRIEND_TEXTBOX_CLICK,onSearchTextboxClicked);
			
			//friends paginator
			friends.friendsPaginator.addEventListener(Paginator_Component.NEXT,friendPaginatorHandler);
			friends.friendsPaginator.addEventListener(Paginator_Component.PREV,friendPaginatorHandler);
			
		}
		
		//Proxies are accessed after multiton key is set
		override public function onRegister () : void
		{
			friendProxy = facade.retrieveProxy(FriendProxy.NAME) as FriendProxy;
			
		}
		/******************************
		/*Getters for view components
		 * ****************************/
		public function get albumBrowser():AlbumBrowser{
			return viewComponent as AlbumBrowser;
		}
		
		public function get friends():FriendsList{
			return albumBrowser.friendsList as FriendsList;
		}
		
		/************************************************
		 * FRIENDS LIST HANDLERS
		 * ***********************************************/
		//Album Selection
		private function onFriendDoubleClick(evt:ListEvent):void{
			//sendNotification(ApplicationFacade.LOAD_ALBUMS,evt.itemRenderer.data as Friend);
		}
		
		private function onMyAlbumsButton(evt:MouseEvent):void{
			//sendNotification(ApplicationFacade.LOAD_ALBUMS,ApplicationFacade.user as AppAccount);
		}
		
		//Friend Search
		private function onSearchStart(evt:Event):void{
			if(friends.friendTextInput.text.length == 0){
				friendProxy.allFriends.filterFunction=null;
			}
			else{
				friends.friendsPaginator.prev.enabled = false;
				friends.friendsPaginator.next.enabled = false;
				
				friendProxy.allFriends.filterFunction=nameFilter;
				friends.list.dataProvider = friendProxy.allFriends;
			}
			
			friendProxy.allFriends.refresh();
		}
		
		private function nameFilter(item:Object):Boolean{
			var content:String = friends.searchbox.text.toLowerCase();
			var key:String = item.name.toLowerCase();
			
			if(key.indexOf(content)!=-1){
				return true
			}
			else{
				return false
			}
		}
		
		private function onSearchTextboxClicked(evt:Event):void{
			
			friends.searchbox.text = "";
			friendProxy.allFriends.filterFunction = null;
			friendProxy.allFriends.refresh();
			
			friendProxy.currPage();
			
		}
		
		/*************************************
		 * Paginator Event Handlers
		 * ***********************************/
		private function friendPaginatorHandler(evt:Event):void{
			trace("friend paginator event: "+evt.type);
			switch (evt.type)
			{
				case Paginator_Component.NEXT:
					friendProxy.nextPage();
					break;
				case Paginator_Component.PREV:
					friendProxy.prevPage();
					break;
			}
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
				/*case ApplicationFacade.THUMB_PAGINATOR_NOTIFICATION:
					
					paginatorData = note.getBody() as PaginatorData;
					
					if(paginatorData.data_class == Album){
						albums.tileList.itemRenderer = new ClassFactory(AlbumThumbRenderer);
					}else if (paginatorData.data_class == Photo){
						albums.tileList.itemRenderer = new ClassFactory(PhotoThumbRenderer);
					}	
					dataProvider = new ArrayCollection(paginatorData.items)
					albums.tileList.dataProvider = dataProvider;
					albums.thumbsPaginator.setStatus(paginatorData);				
					break;*/
				
				case ApplicationConstants.FRIEND_PAGINATOR_NOTIFICATION:
					
					paginatorData = note.getBody() as PaginatorData;
					dataProvider = new ArrayCollection(paginatorData.items);
					friends.list.dataProvider = dataProvider;
					friends.friendsPaginator.setStatus(paginatorData);
					
			}
		}//handleNotification end

	}
}