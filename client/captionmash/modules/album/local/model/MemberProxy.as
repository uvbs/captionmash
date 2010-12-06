package com.captionmashup.modules.album.local.model
{
	import com.captionmashup.common.model.local.paginator.PaginatorEvent;
	import com.captionmashup.common.model.proxy.PaginatorProxy.AbstractPaginatorProxy;
	import com.captionmashup.common.model.proxy.delegate.UserProxyDelegate;
	import com.captionmashup.modules.album.local.facade.ApplicationConstants;
	
	import mx.rpc.AsyncResponder;
	
	public class MemberProxy extends AbstractPaginatorProxy
	{
		public static const NAME:String = "MemberProxy";
		
		public function MemberProxy()
		{
			super(NAME);
		}
		
		public function getUsers(responder:AsyncResponder):void{
			var delegate:UserProxyDelegate = new UserProxyDelegate(responder);
			delegate.getUsers();
		}

		override public function pageHandler(evt:PaginatorEvent):void{
			sendNotification(ApplicationConstants.MEMBER_PAGINATOR_NOTIFICATION,evt.data);
		}
	}
}