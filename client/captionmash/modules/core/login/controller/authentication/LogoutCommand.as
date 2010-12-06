package com.captionmashup.modules.core.login.controller.authentication
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.login.model.LoginProxy;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;

	public class LogoutCommand extends AbstractRPCCommand
	{
		private var loginProxy:LoginProxy;
		
		override public function execute(notification:INotification):void{
			loginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
			
			loginProxy.logout(asyncResponder);
		}
			
		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			loginProxy.user = null;
			t.obj(evt.result,"result in LogoutCommand");
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
			t.obj(evt.fault,"fault in LogoutCommand");
		}
		
	}
}