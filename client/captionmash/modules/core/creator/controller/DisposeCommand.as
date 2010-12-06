package com.captionmashup.modules.core.creator.controller
{

    import com.captionmashup.modules.core.creator.model.CreatorFrameProxy;
    import com.captionmashup.modules.core.creator.model.CreatorProxy;
    import com.captionmashup.modules.core.creator.view.CreatorJunctionMediator;
    import com.captionmashup.modules.core.creator.view.CreatorMediator;
    
    import org.puremvc.as3.multicore.interfaces.ICommand;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
    import org.puremvc.as3.multicore.patterns.facade.Facade;

	/**
	 * Disposes all core actors to avoid issues loading this module again
	 * which means remove all references, listeners etc.
	 * for a successful garbage collection
	 */
    public class DisposeCommand extends SimpleCommand implements ICommand
    {
        override public function execute(note:INotification):void
        {
			trace("DisposeCommand from Creator");
			// remove Mediators to force its onRemove() method
			// for unregistering event listeners, disconnecting pipes etc.
 			facade.removeMediator( CreatorJunctionMediator.NAME );
       		facade.removeMediator( CreatorMediator.NAME );
			facade.removeProxy(CreatorFrameProxy.NAME);
			facade.removeProxy(CreatorProxy.NAME);
       		//
       		// remove proxy
       		//facade.removeProxy( MessagesProxy.NAME );
       		//
       		// remove all core actors registerd of this key
       		Facade.removeCore( Creator.NAME );
       		
       		
        }
        
    }
}