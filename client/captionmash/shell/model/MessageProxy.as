package com.captionmashup.shell.model
{
	import com.captionmashup.common.log.t;
	
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class MessageProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "MessageProxy";
		
		public function MessageProxy()
		{
			super(NAME, new ArrayCollection);
		}
		
		public function get messages():ArrayCollection{
			return data as ArrayCollection;
		}
		
		public function addMessage(msg:Message):void{
			t.obj(msg,"Adding message in MessageProxy");
			messages.addItem(msg);
		}
		
		public function listMessages():void{
		   for each(var msg:Message in messages){
			  
			   t.obj(msg,"Message in messageProxy");
		   }
		}
		
		public function getLatestMessage(msg:Class):*
		{	
			for(var i:int = messages.length-1; i >= 0; i--){
				//If parameter is same type as current msg
				if(getQualifiedClassName(msg)== getQualifiedClassName(messages[i])){
					trace("returning MSG in getLatestMessage");
					return messages.removeItemAt(i) as Message;
				}			
			}
			return null;
		}
	}
}