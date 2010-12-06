package com.captionmashup.modules.core.debug.controller.startup
{
	import com.captionmashup.modules.core.debug.view.DebugJunctionMediator;
	import com.captionmashup.modules.core.debug.view.DebugMediator;
	import com.captionmashup.modules.core.debug.view.components.DebugPanel.DebugPanel;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrepCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			trace("DEBUG VIEWPREP CALLED");

			facade.registerMediator(new DebugMediator(new DebugPanel));
			facade.registerMediator(new DebugJunctionMediator());
		}
	}
}