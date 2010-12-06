package com.captionmashup.modules.core.creator.controller.frame
{
	import com.captionmashup.modules.core.creator.model.CreatorFrameProxy;
	import com.captionmashup.modules.core.creator.view.CreatorMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/*********************************************
	 * Gets contents (captions,propObjects,
	 * filters) from creatorMediator and saves
	 * them into activeFrame in creatorFrameProxy
	 * *******************************************/
	public class SaveFrameCommand extends SimpleCommand
	{
		private var creatorFrameProxy:CreatorFrameProxy;
		private var creatorMediator:CreatorMediator;
		
		override public function execute(notification:INotification):void
		{
			trace("SaveFrameCommand called");
			creatorFrameProxy 		= facade.retrieveProxy(CreatorFrameProxy.NAME) as CreatorFrameProxy;
			creatorMediator 		= facade.retrieveMediator(CreatorMediator.NAME) as CreatorMediator;
			
			//Save current activeFrame in CaptionViewerMediator
			if(creatorFrameProxy.frames != null && creatorFrameProxy.frames.length > 0)
			{
				creatorFrameProxy.activeFrame.captions 		= creatorMediator.getCaptions();
				creatorFrameProxy.activeFrame.propObjects 	= creatorMediator.getPropObjects();
				creatorFrameProxy.activeFrame.filters		= creatorMediator.getFilters();
			}
		}
	}
}