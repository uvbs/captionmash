package com.captionmashup.modules.core.creator.controller.frame
{
	import com.captionmashup.common.model.local.vo.Frame.Frame;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.creator.model.CreatorFrameProxy;
	import com.captionmashup.modules.core.creator.view.CreatorMediator;
	import com.captionmashup.modules.core.creator.view.FrameSelectorMediator;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class AddFrameCommand extends SimpleCommand
	{
		private var creatorFrameProxy:CreatorFrameProxy;
		private var frameSelectorMediator:FrameSelectorMediator;
		private var creatorMediator:CreatorMediator;
		private var frame:Frame;
		private var insertIndex:int;
	
		override public function execute(notification:INotification):void
		{
			trace("AddFrameCommand called");
			//t.obj(notification.getBody(),"frame");
			
			creatorFrameProxy 		= facade.retrieveProxy(CreatorFrameProxy.NAME) as CreatorFrameProxy;
			frameSelectorMediator 	= facade.retrieveMediator(FrameSelectorMediator.NAME) as FrameSelectorMediator;
			creatorMediator 		= facade.retrieveMediator(CreatorMediator.NAME) as CreatorMediator;
			
			frame = notification.getBody() as Frame;
			insertIndex = frameSelectorMediator.lastInsertIndex;
			
			creatorMediator.displayProgressPopup();
			creatorFrameProxy.addFrame(frame,insertIndex);
			
			frameSelectorMediator.lastInsertIndex = 0;
			
			//Finally insert new frame
			//creatorFrameProxy.frames.addItemAt(frame,insertIndex);
			//creatorFrameProxy.activeIndex = insertIndex;
			//creatorFrameProxy.sendActiveFrame();
			//creatorFrameProxy.sendFrames();
			//Get insert index from FrameSelectorMediator
			
			//Insert frame to the relevant position in proxy
		}
	}
}