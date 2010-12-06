package com.captionmashup.modules.core.login.controller.registration
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.login.facade.ApplicationConstants;
	import com.captionmashup.modules.core.login.model.RegistrationProxy;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class CheckEmailCommand extends AbstractRPCCommand
	{
		private var registrationProxy:RegistrationProxy;
		override public function execute(notification:INotification):void{
			trace("CheckEmailCommand called");
			registrationProxy = facade.retrieveProxy(RegistrationProxy.NAME) as RegistrationProxy;
			
			registrationProxy.checkUniqueEmail(notification.getBody() as String,asyncResponder);
		}
		
		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			if(evt.result == true){
				//No match for queried email
				sendNotification(ApplicationConstants.EMAIL_UNIQUE);
			}else{
				//There's an existing email record
				sendNotification(ApplicationConstants.EMAIL_NOT_UNIQUE);
			}
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
			t.obj(evt.fault,"fault in CheckEmailCommand");
		}
	}
}