package com.captionmashup.modules.core.creator.model
{
	import com.captionmashup.common.model.proxy.delegate.CaptionProxyDelegate;
	import com.captionmashup.common.model.local.dto.CaptionDTO;
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	
	import mx.rpc.AsyncResponder;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class CreatorProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "CreatorProxy";
		
		public function CreatorProxy(proxyName:String=null)
		{
			super(NAME, new CaptionDTO);
		}

		//Add caption to existing photo object 
		public function addCaption(captionDTO:CaptionDTO,responder:AsyncResponder):void
		{
			trace("CreatorProxy addCaption called");
			var delegate:CaptionProxyDelegate = new CaptionProxyDelegate(responder);
			delegate.addCaption(captionDTO);
		}

	}
}