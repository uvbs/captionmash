package com.captionmashup.modules.core.creator.controller.photo
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class GetAlbumPhotosCommand extends AbstractRPCCommand
	{
		override public function execute(notification:INotification):void{
			
		}
		
		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
			
		}
	}
}