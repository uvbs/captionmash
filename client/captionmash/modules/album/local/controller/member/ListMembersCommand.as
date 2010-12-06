package com.captionmashup.modules.album.local.controller.member
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	import com.captionmashup.modules.album.local.model.MemberProxy;
	import com.captionmashup.modules.album.local.view.AlbumBrowserMediator;
	import com.captionmashup.modules.album.local.view.BrowserMediator;
	import com.captionmashup.modules.album.local.view.components.Browser.Browser;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class ListMembersCommand extends AbstractRPCCommand
	{
		private var memberProxy:MemberProxy;
		private var browserMediator:BrowserMediator;
		private var albumBrowserMediator:AlbumBrowserMediator;
		
		override public function execute(notification:INotification):void{
			memberProxy = facade.retrieveProxy(MemberProxy.NAME) as MemberProxy;
			browserMediator = facade.retrieveMediator(BrowserMediator.NAME) as BrowserMediator;
			albumBrowserMediator = facade.retrieveMediator(AlbumBrowserMediator.NAME) as AlbumBrowserMediator;
			
			albumBrowserMediator.albumBrowser.tileList.dataProvider = null;
			
			browserMediator.browser.currentState = Browser.MEMBERS_STATE;
			
			memberProxy.getUsers(asyncResponder);
		}
		
		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			t.obj(evt.result,"evt.result in ListMembersCommand");
			memberProxy.setPaginator(evt.result as Array,ApplicationConstants.MEMBER_LIST_PAGE_SIZE);
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
			t.obj(evt.fault,"evt.fault in ListMembersCommand.faultHandler");
		}
	}
}