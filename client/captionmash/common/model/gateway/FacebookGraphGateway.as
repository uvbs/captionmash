package com.captionmashup.common.model.gateway
{
	import com.adobe.serialization.json.JSON;
	import com.captionmashup.common.CommonConstants;
	
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	import sk.yoz.events.FacebookOAuthGraphEvent;
	import sk.yoz.net.FacebookOAuthGraph;
	
	
	public final class FacebookGraphGateway
	{
		
		private static var facebook:FacebookOAuthGraph;
		
		public static function getConnection():FacebookOAuthGraph
		{
			if (facebook == null)
			{
				facebook = new FacebookOAuthGraph();
				
				facebook.clientId 		= CommonConstants.FACEBOOK_CLIENT_ID;
				facebook.redirectURI 	= CommonConstants.FACEBOOK_REDIRECT_URI;
				facebook.scope 			= CommonConstants.FACEBOOK_PERMISSION_SCOPE;
				
				facebook.useSecuredPath = true;
				
			}
			return facebook;
		}
		
		
		public static function call(path:String, binary:Boolean,listener:Function,pagingLimit:int = 0 ):void
		{
			if(pagingLimit > 0){
				var data:URLVariables = new URLVariables();
				data.limit = pagingLimit;
			}
			
			var loader:URLLoader = facebook.call(path,data);
			loader.dataFormat = binary
				? URLLoaderDataFormat.BINARY
				: URLLoaderDataFormat.TEXT;
			loader.addEventListener(FacebookOAuthGraphEvent.DATA, listener);
			//	log.text += "call(" + path + ")\n";
			
		}
		
		public static function callFQL(query:String,listener:Function):void{
			var data:URLVariables = new URLVariables();
			data.query = query;
			
			data.format = "JSON";
			var loader:URLLoader = facebook.call("method/fql.query", data,
				URLRequestMethod.POST, null, "https://api.facebook.com");
			loader.addEventListener(FacebookOAuthGraphEvent.DATA, listener);
			
			trace("fql call: "+data.query);
		}
		
		
		//queries object must have name:value pairs both string
		public static function callMultipleFQL(queries:Object,listener:Function):void{
			var data:URLVariables = new URLVariables();	
			data.queries = JSON.encode(queries);
			data.format = "JSON";
			
			var loader:URLLoader = facebook.call("method/fql.multiquery", data,
				URLRequestMethod.POST, null, "https://api.facebook.com");
			loader.addEventListener(FacebookOAuthGraphEvent.DATA, listener);
			
			trace("fql call: "+data.queries);
		}
		
		public static function commentTest(comment:String):void{
			var data:URLVariables = new URLVariables();
			data.text = comment;
			data.object_id ="10150201783515556";
			data.format = "JSON";
			
			facebook.call("method/comments.add", data, 
				URLRequestMethod.POST, null, "https://api.facebook.com");	
		}
		
		public static function streamPublish(message:String,friend_id:String = ""):void{
			var data:URLVariables = new URLVariables();
			var privacy:Object = new Object();
			
			if(friend_id != ""){
				data.target_id = friend_id;
			}
			
			data.message = message;
			data.format = "JSON";
			
			facebook.call("method/stream.publish", data, 
				URLRequestMethod.POST, null, "https://api.facebook.com");
		}
	
	}
}