package com.captionmashup.modules.core.creator.controller.frame
{
	import com.captionmashup.modules.core.creator.model.CreatorFrameProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ClearFramesCommand extends SimpleCommand
	{
		private var creatorFrameProxy:CreatorFrameProxy;
		
		override public function execute(notification:INotification):void{
			trace("ClearFramesCommand called");
			creatorFrameProxy = facade.retrieveProxy(CreatorFrameProxy.NAME) as CreatorFrameProxy;
			
			creatorFrameProxy.frames = null
		}
	}
}