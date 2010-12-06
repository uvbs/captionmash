package com.captionmashup.modules.album.flickr.controller.startup
{

	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import com.captionmashup.common.log.t;
	
	public class ModelPrep extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("FLICKR MODELPREP COMMAND CALLED");
			// register proxy

		}
	}
}