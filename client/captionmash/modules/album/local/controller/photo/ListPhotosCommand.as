package com.captionmashup.modules.album.local.controller.photo
{
	import com.captionmashup.common.model.local.dto.AlbumDTO;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	import com.captionmashup.modules.album.local.model.PhotoProxy;
	import com.captionmashup.modules.album.local.view.BrowserMediator;
	import com.captionmashup.modules.album.local.view.components.Browser.Browser;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ListPhotosCommand extends SimpleCommand
	{
		private var photoProxy:PhotoProxy;
		private var browserMediator:BrowserMediator;
		
		override public function execute(notification:INotification):void
		{
			trace("ListPhotosCommand called");
			var albumDTO:AlbumDTO = notification.getBody() as AlbumDTO;
			photoProxy = facade.retrieveProxy(PhotoProxy.NAME) as PhotoProxy;
			browserMediator = facade.retrieveMediator(BrowserMediator.NAME) as BrowserMediator;
			
			browserMediator.browser.currentState = Browser.PHOTOS_STATE;
			
			photoProxy.getAlbumPhotos(albumDTO.django_id,new AsyncResponder(resultHandler,faultHandler));		
		}
		
		private function resultHandler(evt:ResultEvent,token:Object=null):void{
			t.obj(evt.result,"evt.result[0] in ListPhotosCommand");
			photoProxy.setPaginator(evt.result as Array,
									ApplicationConstants.PHOTO_LIST_PAGE_SIZE,
									"page_no",true);
		}
		
		private function faultHandler(faultEvent:FaultEvent,token:Object=null):void{
			t.obj(faultEvent.fault,"evt.fault in ListPhotosCommand.faultHandler");
		}
	}
}