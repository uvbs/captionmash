
package com.captionmashup.shell.controller
{

    import captionmashup.shell.model.MessagesProxy;
    import org.puremvc.as3.multicore.interfaces.ICommand;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	/**
	 * Show and store message
	 */
    public class AddMessageCommand extends SimpleCommand implements ICommand
    {
        override public function execute(note:INotification):void
        {
        	var message: String = note.getBody() as String;
			
			trace("message in  AddMessageCommand: "+note.getBody());
       		//
       		// store message using MessagesProxy
       		//var messagesProxy: MessagesProxy = facade.retrieveProxy( MessagesProxy.NAME ) as MessagesProxy;
       		//messagesProxy.addMessage( message );
        	//
			// show message at the view component
 			//var helloPipesShellMediator: HelloPipesShellMediator = facade.retrieveMediator( HelloPipesShellMediator.NAME ) as HelloPipesShellMediator;
       		//helloPipesShellMediator.updateMessages( messagesProxy.messages );
       		
       		
        }
        
    }
}