package com.captionmashup.modules.core.viewer.controller.startup
{
	import com.captionmashup.modules.core.viewer.view.FrameSelectorMediator;
	import com.captionmashup.modules.core.viewer.view.ViewerJunctionMediator;
	import com.captionmashup.modules.core.viewer.view.ViewerMediator;
	import com.captionmashup.modules.core.viewer.view.components.CaptionViewer.CaptionViewer;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("VIEWER VIEWPREP COMMAND CALLED");
			var captionViewer:CaptionViewer = new CaptionViewer();
			captionViewer.initialize();
			captionViewer.overlay.bottomDeck.frameSelector.initialize();
			
			facade.registerMediator(new ViewerJunctionMediator());
			facade.registerMediator(new ViewerMediator(captionViewer));
			facade.registerMediator(new FrameSelectorMediator(captionViewer.overlay.bottomDeck.frameSelector));
		}
	}
}