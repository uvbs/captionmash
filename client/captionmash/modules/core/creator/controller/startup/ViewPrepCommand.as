package com.captionmashup.modules.core.creator.controller.startup
{
	import com.captionmashup.modules.core.creator.view.CreatorJunctionMediator;
	import com.captionmashup.modules.core.creator.view.CreatorMediator;
	import com.captionmashup.modules.core.creator.view.FrameSelectorMediator;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("CREATOR VIEWPREP COMMAND CALLED");
			// Create and Register the SimpleModule Junction and its Mediator
			facade.registerMediator( new CreatorJunctionMediator() );
			//
			// Create and Register the Module and its Mediator
			//var app: SimpleModule = note.getBody() as SimpleModule;
			var app:Creator= notification.getBody() as Creator;
			app.captionEditor.initialize();
			//facade.registerMediator( new CreatorMediator( app ) );
			facade.registerMediator(new CreatorMediator(app.captionEditor));	
			facade.registerMediator(new FrameSelectorMediator(app.captionEditor.overlay.frameSelector));
		}
	}
}