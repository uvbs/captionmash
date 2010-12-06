package com.captionmashup.shell.controller.module
{
	import flash.system.ApplicationDomain;
	
	import mx.events.FlexEvent;
	import mx.events.ModuleEvent;
	import mx.managers.CursorManager;
	import mx.modules.Module;
	import mx.modules.ModuleLoader;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.AsyncCommand;
	
	/******************************************
	 * This is a generic AsyncCommand that is
	 * called by each module's loader 
	 * MacroCommand
	 * 
	 * Usage:
	 * Notification Body = ModuleLoader instance
	 * Notification Type = Module URL
	 * ****************************************/
	public class LoadModuleAsyncCommand extends AsyncCommand
	{
		override public function execute ( note:INotification ) : void
		{
			var moduleLoader:ModuleLoader = note.getBody() as ModuleLoader;
			var moduleURL:String = note.getType();
			
			trace("LoadModuleAsyncCommand called, moduleURL: "+moduleURL);
			
			//Load the module of note's moduleLoader
			moduleLoader.addEventListener(ModuleEvent.READY,moduleReadyHandler);
			CursorManager.setBusyCursor();
			//if ( moduleLoader.child != null ) 
			//	removeModule( null );
			
			moduleLoader.applicationDomain = ApplicationDomain.currentDomain;
			moduleLoader.url = moduleURL;
			moduleLoader.loadModule();
			//moduleLoader.visible = true;
		}
		
		private function moduleReadyHandler(evt:ModuleEvent):void{
			
			var moduleLoader:ModuleLoader = ModuleLoader(evt.target) ;
			
			moduleLoader.removeEventListener(ModuleEvent.READY,moduleReadyHandler);
			moduleLoader.child.addEventListener(FlexEvent.INITIALIZE,moduleInitializeHandler);
			CursorManager.removeBusyCursor();
			trace("moduleReadyHandler called");
		}
		
		private function moduleInitializeHandler(evt:FlexEvent):void{
			var module:Module = Module(evt.target);
			trace("moduleInitializeHandler called");
			trace("evt.target in moduleInitializeHandler: "+module);
			module.removeEventListener(FlexEvent.INITIALIZE,moduleInitializeHandler);
			commandComplete();
		}
	}
}