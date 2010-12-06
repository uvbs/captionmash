package com.captionmashup.common.model.gateway
{
	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.common.log.t;
	
	import flash.system.ApplicationDomain;
	
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class MainGateway
	{
		private static var captionService:RemoteObject;
		private static var accountService:RemoteObject;
		private static var albumService:RemoteObject;
		
		private static var gateway_instance:RemoteObject;
		
		private static var gatewayURL:String = CommonConstants.gatewayURL;
		//online	
		//private static var gatewayURL:String = "http://www.captionmashup.com/gateway/"			
		
		public static function getInstance():RemoteObject
		{
			if(gateway_instance == null)
			{
				// Create the AMF Channel
				var channel:AMFChannel= new AMFChannel( "pyamf-channel", gatewayURL);
				channel.connectTimeout = 10;
				// Create a channel set and add your channel(s) to it
				var channels:ChannelSet = new ChannelSet();
				channels.addChannel( channel );
				
				
				// Create a new remote object and add listener(s)
				gateway_instance = new RemoteObject(); // this is the service id
				gateway_instance.channelSet = channels;
			}
			return gateway_instance;
		}
			
			
		public static function getCaptionService():RemoteObject
		{
			if (captionService == null)
			{
				// Create the AMF Channel
				var channel:AMFChannel= new AMFChannel( "pyamf-channel", gatewayURL);
				channel.connectTimeout = 10;
				// Create a channel set and add your channel(s) to it
				var channels:ChannelSet = new ChannelSet();
				channels.addChannel( channel );
				
				
				// Create a new remote object and add listener(s)
				captionService = new RemoteObject( "CaptionService" ); // this is the service id
				captionService.channelSet = channels;
				
				
			}
			return captionService;
			
		}
		
		public static function getAccountService():RemoteObject
		{
			if (accountService == null)
			{
				// Create the AMF Channel
				var channel:AMFChannel= new AMFChannel( "pyamf-channel", gatewayURL );
				channel.connectTimeout = 10;
				// Create a channel set and add your channel(s) to it
				var channels:ChannelSet = new ChannelSet();
				channels.addChannel( channel );

				// Create a new remote object and add listener(s)
				accountService = new RemoteObject( "AccountService" ); // this is the service id
				accountService.channelSet = channels;
			}
			return accountService;
		}
		
		public static function getAlbumService():RemoteObject
		{
			//t.obj(ApplicationDomain.currentDomain,"appDom from mainGateway");
			
			if (albumService == null)
			{
				// Create the AMF Channel
				var channel:AMFChannel= new AMFChannel( "pyamf-channel", gatewayURL );
				channel.connectTimeout = 10;
				// Create a channel set and add your channel(s) to it
				var channels:ChannelSet = new ChannelSet();
				channels.addChannel( channel );
				
				// Create a new remote object and add listener(s)
				albumService = new RemoteObject( "AlbumService" ); // this is the service id
				albumService.channelSet = channels;
			}
			return albumService;
		}
		
		
		
	}
}