
package com.captionmashup.shell.controller
{

    import mx.collections.ArrayCollection;
    

    import com.captionmashup.shell.view.mediator.ShellJunctionMediator;
    import org.puremvc.as3.multicore.interfaces.ICommand;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	/**
	 * To show and store message
	 */
    public class ModuleRemovedCommand extends SimpleCommand implements ICommand
    {
        override public function execute(note:INotification):void
        {
        	var message: String = note.getBody() as String;
       		//
       		// clear messages stored within MessagesProxy
       		//var messagesProxy: MessagesProxy = facade.retrieveProxy( MessagesProxy.NAME ) as MessagesProxy;
       		//messagesProxy.messages = new ArrayCollection();
        	//
			// disconnect pipes
 			var shellJunciointMediator: ShellJunctionMediator = facade.retrieveMediator( ShellJunctionMediator.NAME ) as ShellJunctionMediator;
       		shellJunciointMediator.disconnectModule( );

        }
        
    }
}