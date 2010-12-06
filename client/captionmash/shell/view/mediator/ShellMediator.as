package com.captionmashup.shell.view.mediator
{
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ShellMediator extends Mediator
	{
		public static const NAME:String = "ShellMediator");
		public function ShellMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
	}
}