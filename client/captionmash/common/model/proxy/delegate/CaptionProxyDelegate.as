package com.captionmashup.common.model.proxy.delegate
{
	import com.captionmashup.common.model.gateway.MainGateway;
	import com.captionmashup.common.model.local.dto.CaptionDTO;
	import com.captionmashup.common.model.local.dto.PhotoDTO;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	
	public class CaptionProxyDelegate
	{
		private var _token:AsyncToken;
		private var _responder:AsyncResponder;
		
		public static const GET_CAPTION:String = "token/get_caption";
		public static const POST_CAPTION:String = "token/post_caption";
		
		public function CaptionProxyDelegate(responder:AsyncResponder)
		{
			_responder = responder;	
		}
		
		public function getCaptionByLink(link:String):void{
			_token = MainGateway.getCaptionService().getCaptionByLink(link);
			_token.type = GET_CAPTION;
			_token.addResponder(_responder);		
		}
		
		public function addCaption(captionDTO:CaptionDTO):void{
			trace("captionProxyDelegate addCaption called");
			_token = MainGateway.getCaptionService().addCaption(captionDTO);
			_token.type = POST_CAPTION;
			_token.addResponder(_responder);
		}
		
		public function getLatestCaptions():void{
			trace("captionProxyDelegate getLatestCaptions called");
			_token = MainGateway.getCaptionService().getLatestCaptions();
			_token.type = GET_CAPTION;
			_token.addResponder(_responder);
		}
		
	}
}