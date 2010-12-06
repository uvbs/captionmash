package com.captionmashup.modules.core.creator.model
{
	import com.captionmashup.common.model.proxy.delegate.PhotoProxyDelegate;
	
	import mx.rpc.AsyncResponder;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class PhotoProxy extends Proxy
	{
		public static const NAME:String 	= "PhotoProxy";
		public function PhotoProxy()
		{
			super(NAME);
		}
		
		
		public function getPhotoByLink(photo_link:String,asyncResponder:AsyncResponder):void{
			var delegate:PhotoProxyDelegate = new PhotoProxyDelegate(asyncResponder);
			delegate.getPhotoByLink(photo_link);
		}

	}
}