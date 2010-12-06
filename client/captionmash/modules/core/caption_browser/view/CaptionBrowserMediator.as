package com.captionmashup.modules.core.caption_browser.view
{
	import com.captionmashup.common.model.local.dto.CaptionDTO;
	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.model.proxy.PaginatorProxy.IPaginatorProxy;
	import com.captionmashup.common.pipe.message.core.ViewerMessage;
	import com.captionmashup.common.view.component.SparkThumbnailTileList.SparkThumbnailTileList;
	import com.captionmashup.common.view.mediator.PaginatorMediator.AbstractPaginatorMediator;
	import com.captionmashup.modules.core.caption_browser.facade.ApplicationConstants;
	import com.captionmashup.modules.core.caption_browser.model.CaptionProxy;
	import com.captionmashup.modules.core.caption_browser.view.components.CaptionBrowser.ItemRenderer.CaptionRenderer;
	
	import mx.core.ClassFactory;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import spark.events.IndexChangeEvent;
		
	public class CaptionBrowserMediator extends AbstractPaginatorMediator
	{
		public static const NAME:String = "CaptionBrowserMediator";
		
		public function CaptionBrowserMediator(viewComponent:SparkThumbnailTileList)
		{
			super(NAME, viewComponent);
			captionBrowser.tileList.itemRenderer = new ClassFactory(CaptionRenderer);
			captionBrowser.setSize(ApplicationConstants.CAPTION_THUMB_LIST_ROW_COUNT,
											ApplicationConstants.CAPTION_THUMB_LIST_COLUMN_COUNT);

			captionBrowser.tileList.addEventListener(IndexChangeEvent.CHANGE,onCaptionClick);
		}
		
		public function get captionBrowser():SparkThumbnailTileList{
			return viewComponent as SparkThumbnailTileList;
		}
		
		override public function onRegister():void{
			paginatorProxy = facade.retrieveProxy(CaptionProxy.NAME) as IPaginatorProxy;
		}

		private function onCaptionClick(evt:IndexChangeEvent):void{
			trace("Caption selected in CaptionBrowserMediator");
			var message:ViewerMessage = new ViewerMessage(ViewerMessage.START_VIEW,
												captionBrowser.tileList.selectedItem as CaptionDTO);
		
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,message);
			
			//Deselect item for reclick
			captionBrowser.tileList.selectedIndex = -1;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.CAPTION_PAGINATOR_NOTIFICATION,
				
			];
		}
		
		override public function handleNotification(note:INotification):void
		{	
			switch (note.getName())
			{		
				case ApplicationConstants.CAPTION_PAGINATOR_NOTIFICATION:
					updateSparkView(note.getBody() as PaginatorData,captionBrowser.tileList);
					break;	
			}
		}//handleNotification end
	}
}