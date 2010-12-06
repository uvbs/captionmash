package com.captionmashup.modules.core.viewer.model
{
	import com.captionmashup.common.model.local.dto.CaptionDTO;
	import com.captionmashup.common.model.proxy.delegate.CaptionProxyDelegate;
	
	import mx.rpc.AsyncResponder;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class CaptionProxy extends Proxy
	{
		public static const NAME:String = "CaptionProxy";
		
		public function CaptionProxy()
		{
			super(NAME, new CaptionDTO);
		}
		
		public function get caption():CaptionDTO{
			return data as CaptionDTO;
		}
		
		public function set caption(value:CaptionDTO):void{
			data = value;
		}
		
		public function getCaptionByLink(link:String,responder:AsyncResponder):void{
			var delegate:CaptionProxyDelegate = new CaptionProxyDelegate(responder);
			delegate.getCaptionByLink(link);
		}
	}
}