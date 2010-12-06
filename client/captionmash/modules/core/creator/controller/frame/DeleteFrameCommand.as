package com.captionmashup.modules.core.creator.controller.frame
{
	import com.captionmashup.modules.core.creator.model.CreatorFrameProxy;
	import com.captionmashup.modules.core.creator.view.CreatorMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class DeleteFrameCommand extends SimpleCommand
	{
		private var creatorMediator:CreatorMediator;
		private var creatorFrameProxy:CreatorFrameProxy;
		override public function execute(notification:INotification):void{
			creatorFrameProxy 	= facade.retrieveProxy(CreatorFrameProxy.NAME) as CreatorFrameProxy;
			creatorMediator 	= facade.retrieveMediator(CreatorMediator.NAME) as CreatorMediator; 
			
			//trace("DeleteFrameCommand called, removeIndex: "+notification.getBody());
			//trace("CreatorFrameProxy.frames.length: "+creatorFrameProxy.frames.length);
			//trace("Active Index : "+creatorFrameProxy.activeIndex);
			var removeIndex:int = int(notification.getBody());
			creatorFrameProxy.removeFrame(removeIndex);
			
			//trace("REMOVED CreatorFrameProxy.frames.length: "+creatorFrameProxy.frames.length);
			//trace("REMOVED Active Index : "+creatorFrameProxy.activeIndex);
		}
	}
}