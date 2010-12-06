package com.captionmashup.modules.core.popup.controller.startup
{
	import com.captionmashup.modules.core.popup.view.PopupJunctionMediator;
	import com.captionmashup.modules.core.popup.view.PopupMediator;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("POPUPMODULE VIEWPREP COMMAND CALLED");
			facade.registerMediator(new PopupJunctionMediator());
			facade.registerMediator(new PopupMediator());
		}
	}
}