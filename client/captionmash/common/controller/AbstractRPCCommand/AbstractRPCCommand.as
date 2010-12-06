package com.captionmashup.common.controller.AbstractRPCCommand
{
	import mx.rpc.AsyncResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class AbstractRPCCommand extends SimpleCommand
	{
		protected var asyncResponder:AsyncResponder;
		
		public function AbstractRPCCommand(){
			asyncResponder = new AsyncResponder(onResult,onFault);
		}
		
		override public function execute(notification:INotification):void{
			throw new Error("execute() function must be overridden");
		}
		
		protected function onResult(evt:ResultEvent,token:Object=null):void{
			throw new Error("onResult() function must be overridden");
		}
		
		protected function onFault(evt:FaultEvent,token:Object=null):void{
			throw new Error("onFault() function must be overridden");
		}
	}
}