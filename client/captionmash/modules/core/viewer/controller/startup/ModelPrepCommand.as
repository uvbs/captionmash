package com.captionmashup.modules.core.viewer.controller.startup
{
	
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.viewer.model.CaptionProxy;
	import com.captionmashup.modules.core.viewer.model.FrameProxy;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ModelPrepCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			trace("VIEWER MODELPREP COMMAND CALLED");
			// register proxy
			facade.registerProxy(new FrameProxy());
			facade.registerProxy(new CaptionProxy());
			
		}
	}
}