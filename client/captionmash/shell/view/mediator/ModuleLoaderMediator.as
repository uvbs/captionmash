package com.captionmashup.shell.view.mediator
{
	import com.captionmashup.shell.view.components.AppScreen.AppScreen;
	
	import mx.modules.ModuleLoader;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/******************************************
	 * ModuleLoaderMediator is used by module
	 * loading commands for easy access to
	 * related ModuleLoaders
	 * ***************************************/
	
	public class ModuleLoaderMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ModuleLoaderMediator";
		private var creator_loader:ModuleLoader;
		private var facebook_loader:ModuleLoader;
		
		public function ModuleLoaderMediator( viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			creator_loader  = new ModuleLoader();	
			facebook_loader = new ModuleLoader();
		}
		
		public function get appScreen():AppScreen{
			return viewComponent as AppScreen;
		}
		
		public function get creatorLoader():ModuleLoader{
			return creator_loader;//appScreen.creatorLoader;	
		}
		
		public function get facebookLoader():ModuleLoader{
			return facebook_loader;//appScreen.creatorLoader;	
		}
	}
}