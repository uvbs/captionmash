package com.captionmashup.modules.album.flickr.controller.startup
{

	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrep extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("FLICKR VIEWPREP COMMAND CALLED");

			// Create and Register the SimpleModule Junction and its Mediator
			//facade.registerMediator( new CreatorJunctionMediator() );
			//
			// Create and Register the Module and its Mediator
			//var app: SimpleModule = note.getBody() as SimpleModule;
			//facade.registerMediator( new CreatorMediator( app ) );
		}
	}
}