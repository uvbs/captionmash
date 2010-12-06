package com.captionmashup.modules.album.local.view
{
	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.model.proxy.PaginatorProxy.IPaginatorProxy;
	import com.captionmashup.common.view.component.ItemRenderer.UserRenderer.UserRenderer;
	import com.captionmashup.common.view.component.SparkThumbnailTileList.SparkThumbnailTileList;
	import com.captionmashup.common.view.mediator.PaginatorMediator.AbstractPaginatorMediator;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	import com.captionmashup.modules.album.local.model.MemberProxy;
	
	import mx.core.ClassFactory;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import spark.events.IndexChangeEvent;
	
	public class MemberBrowserMediator extends AbstractPaginatorMediator
	{
		public static const NAME:String = "MemberBrowserMediator";
		
		public function MemberBrowserMediator(viewComponent:SparkThumbnailTileList)
		{
			super(NAME, viewComponent);
			memberBrowser.setSize(ApplicationConstants.MEMBER_LIST_ROW_COUNT,
									ApplicationConstants.MEMBER_LIST_COLUMN_COUNT);
			memberBrowser.tileList.itemRenderer = new ClassFactory(UserRenderer);
			
			memberBrowser.tileList.addEventListener(IndexChangeEvent.CHANGE, onIndexChange);
		}
		
		public function get memberBrowser():SparkThumbnailTileList{
			return viewComponent as SparkThumbnailTileList;
		}
		
		override public function onRegister():void{
			paginatorProxy = facade.retrieveProxy(MemberProxy.NAME) as IPaginatorProxy;
		}
		
		private function onIndexChange(evt:IndexChangeEvent):void{
			sendNotification(ApplicationConstants.LIST_USER_ALBUMS,memberBrowser.tileList.selectedItem);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.MEMBER_PAGINATOR_NOTIFICATION,
			];
		}
		
		override public function handleNotification(note:INotification):void
		{	
			switch (note.getName())
			{
				case ApplicationConstants.MEMBER_PAGINATOR_NOTIFICATION:
					updateSparkView(note.getBody() as PaginatorData,memberBrowser.tileList);
					break;	
			}
		}//handleNotification end
		
		
	}
}