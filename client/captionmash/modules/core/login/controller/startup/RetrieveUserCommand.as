package com.captionmashup.modules.core.login.controller.startup
{
	import com.captionmashup.common.controller.AbstractRPCCommand.AbstractRPCCommand;
	import com.captionmashup.common.model.local.dto.UserDTO;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.login.facade.ApplicationConstants;
	import com.captionmashup.modules.core.login.model.LoginProxy;
	import com.captionmashup.modules.core.login.view.LoginBarMediator;
	import com.captionmashup.modules.core.login.view.components.LoginBar.LoginBar;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/*********************************
	 * Called at login module startup
	 * 
	 * Tries to retreve User through 
	 * session, if no session is present
	 * null is stored in
	 * loginProxy
	 * *******************************/
	public class RetrieveUserCommand extends AbstractRPCCommand
	{
		private var loginProxy:LoginProxy;
		private var loginBarMediator:LoginBarMediator;
		
		override public function execute(notification:INotification):void
		{
			trace("RetrieveUserCommand called");
			loginBarMediator = facade.retrieveMediator(LoginBarMediator.NAME) as LoginBarMediator;
			loginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
			
			loginBarMediator.loginBar.currentState = LoginBar.RETRIEVING_USER_STATE;
			
			loginProxy.retrieveUser(asyncResponder);
		}
		
		override protected function onResult(evt:ResultEvent, token:Object=null):void{
			t.obj(evt.result,"evt.result in RetrieveUserCommand");
			if(evt.result is UserDTO){
				trace("user is logged in");
				loginProxy.user = evt.result as UserDTO;
			}else{
				trace("user is not logged in");
				loginProxy.user = null;
			}
		}
		
		override protected function onFault(evt:FaultEvent, token:Object=null):void{
			t.obj(evt.fault,"RetrieveUserCommand fault");
		}
		
	}
}