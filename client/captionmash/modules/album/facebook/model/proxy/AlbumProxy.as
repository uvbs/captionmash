package com.captionmashup.modules.album.facebook.model.proxy
{
	import com.captionmashup.common.model.foreign.IAccount;
	import com.captionmashup.common.model.local.paginator.PaginatorEvent;
	import com.captionmashup.common.model.proxy.PaginatorProxy.AbstractPaginatorProxy;
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	import com.captionmashup.modules.album.facebook.model.dto.Album;
	import com.captionmashup.common.model.gateway.FacebookGraphGateway;
	import com.captionmashup.modules.album.facebook.fql.FqlCreateUtil;
	
	import com.captionmashup.common.log.t;
	
	public class AlbumProxy extends AbstractPaginatorProxy
	{
		public static const NAME:String = "AlbumProxy";
		
		public function AlbumProxy()
		{
			super(NAME);	
		}
		
		public function loadAlbums(account:IAccount,callback:Function):void{
			t.obj(account,"Loading albums from AlbumProxy.loadalbums");
			
			//Query object for FQL
			var queryObject:Object = new Object();
			queryObject = FqlCreateUtil.createAlbumFQL(account.getAccountId());
			FacebookGraphGateway.callMultipleFQL(queryObject,callback);
		}
		
		//This function is added as listener in AbstractPaginatorProxy
		override public function pageHandler(evt:PaginatorEvent):void{
			sendNotification(ApplicationConstants.ALBUM_PAGINATOR_NOTIFICATION,evt.data);
		}
		
		
	}
}