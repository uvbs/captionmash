package com.captionmashup.modules.album.local.view
{
	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.model.proxy.PaginatorProxy.IPaginatorProxy;
	import com.captionmashup.common.view.component.SparkThumbnailTileList.SparkThumbnailTileList;
	import com.captionmashup.common.view.mediator.PaginatorMediator.AbstractPaginatorMediator;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	import com.captionmashup.modules.album.local.model.GenreProxy;
	import com.captionmashup.modules.album.local.view.components.Browser.ItemRenderer.GenreRenderer;
	
	import flash.events.MouseEvent;
	
	import mx.core.ClassFactory;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import spark.events.IndexChangeEvent;
	
	public class GenreBrowserMediator extends AbstractPaginatorMediator
	{
		
		public static const NAME:String = "GenreBrowserMediator";
		
		public function GenreBrowserMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
			
			genreBrowser.tileList.itemRenderer = new ClassFactory(GenreRenderer);
			
			genreBrowser.setSize(ApplicationConstants.GENRE_LIST_ROW_COUNT,
				ApplicationConstants.GENRE_LIST_COLUMN_COUNT);
			
			genreBrowser.tileList.addEventListener(IndexChangeEvent.CHANGE,onIndexChange);
		}
		
		private function onIndexChange(evt:IndexChangeEvent):void{
			trace("GenreBrowser clicked");
			t.obj(genreBrowser.tileList.selectedItem,"selected item in genre browser");
			sendNotification(ApplicationConstants.LIST_GENRE_ALBUMS,genreBrowser.tileList.selectedItem);
			genreBrowser.tileList.selectedIndex = -1;
		}
		public function get genreBrowser():SparkThumbnailTileList{
			return viewComponent as SparkThumbnailTileList;
		}
		
		override public function onRegister():void{
			paginatorProxy = facade.retrieveProxy(GenreProxy.NAME) as IPaginatorProxy;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.GENRE_PAGINATOR_NOTIFICATION,
			];
		}
		
		override public function handleNotification(note:INotification):void
		{	
			switch (note.getName())
			{
				case ApplicationConstants.GENRE_PAGINATOR_NOTIFICATION:
					trace("Handling GENRE_PAGINATOR_NOTIFICATION in GenreBrowserMediatorrrrr");
					updateSparkView(note.getBody() as PaginatorData,genreBrowser.tileList);
					break;	
			}
		}//handleNotification end
	}
}