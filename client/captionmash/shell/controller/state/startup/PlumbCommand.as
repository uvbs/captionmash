package com.captionmashup.shell.controller.state.startup
{
	import com.captionmashup.common.pipe.PipeAwareModuleConstants;
	import com.captionmashup.common.pipe.message.album.LocalAlbumMessage;
	import com.captionmashup.common.pipe.message.core.AlbumContainerMessage;
	import com.captionmashup.common.pipe.message.core.CaptionBrowserMessage;
	import com.captionmashup.common.pipe.message.core.LoginMessage;
	import com.captionmashup.modules.album.local.LocalAlbumModule;
	import com.captionmashup.modules.core.album_container.AlbumContainerModule;
	import com.captionmashup.modules.core.basket.BasketModule;
	import com.captionmashup.modules.core.caption_browser.CaptionBrowserModule;
	import com.captionmashup.modules.core.debug.DebugModule;
	import com.captionmashup.modules.core.login.LoginModule;
	import com.captionmashup.modules.core.popup.PopupModule;
	import com.captionmashup.modules.core.album_manager.AlbumManagerModule;
	import com.captionmashup.modules.core.viewer.ViewerModule;
	import com.captionmashup.shell.facade.ShellConstants;
	import com.captionmashup.shell.view.mediator.ShellJunctionMediator;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Pipe;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeMerge;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeSplit;
	import org.puremvc.as3.multicore.utilities.statemachine.StateMachine;
	
	public class PlumbCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void
		{
			trace("PLUMBCOMMAND CALLED");
			
			// --------------------------------------------
			// Prepare Shell
			// --------------------------------------------
			
			// Create a Junction for the Shell
			var shellJunction:Junction = new Junction();
			
			// Register the ShellJunctionMediator with this Junction
			var shellJunctionMediator:ShellJunctionMediator = new ShellJunctionMediator( shellJunction );
			facade.registerMediator( shellJunctionMediator );
			
			// Create the STDOUT splitting tee for communicating from the Shell to all modules 
			var shellOutTee:TeeSplit= new TeeSplit();
			shellJunction.registerPipe( PipeAwareModuleConstants.STDOUT,  Junction.OUTPUT, shellOutTee );
			
			// The STDIN merging tee for communicating to the Shell from all modules 
			var shellInTee:TeeMerge = new TeeMerge();
			shellJunction.registerPipe( PipeAwareModuleConstants.STDIN,  Junction.INPUT, shellInTee );
			shellJunction.addPipeListener( PipeAwareModuleConstants.STDIN, this, shellJunctionMediator.handlePipeMessage );
			
			// --------------------------------------------
			// Connect Shell < - > PopupModule
			// --------------------------------------------
			var popupModule:PopupModule = new PopupModule();
			
			var shellToPopupModulePipe:IPipeFitting = new Pipe();
			shellJunction.registerPipe(PopupModule.NAME,Junction.OUTPUT,shellToPopupModulePipe);
			
			var popupInTee:TeeMerge = new TeeMerge();
			popupInTee.connectInput(shellOutTee);
			popupModule.acceptInputPipe(PipeAwareModuleConstants.STDIN,popupInTee);
			
			var popupModuleToShellPipe:Pipe = new Pipe();
			shellInTee.connectInput(popupModuleToShellPipe);
			popupModule.acceptOutputPipe(PipeAwareModuleConstants.STDOUT,popupModuleToShellPipe);
			
			// --------------------------------------------
			// Connect Shell < - > DebugModule
			// --------------------------------------------
			var debugModule:DebugModule = new DebugModule;
			shellJunctionMediator.connectModule(debugModule);
			
			// --------------------------------------------
			// Connect Shell < - > AlbumContainerModule
			// --------------------------------------------
			var albumContainerModule:AlbumContainerModule = new AlbumContainerModule;
			shellJunctionMediator.connectModule(albumContainerModule);
			shellJunctionMediator.sendMessage(new AlbumContainerMessage(AlbumContainerMessage.GET_UI));
			
			// --------------------------------------------
			// Connect Shell < - > LocalAlbumModule
			// --------------------------------------------
			var localAlbumModule:LocalAlbumModule = new LocalAlbumModule;
			shellJunctionMediator.connectModule(localAlbumModule);
			shellJunctionMediator.sendMessage(new LocalAlbumMessage(LocalAlbumMessage.GET_UI));
			
			// --------------------------------------------
			// Connect Shell < - > CaptionBrowserModule
			// --------------------------------------------
			var captionBrowserModule:CaptionBrowserModule = new CaptionBrowserModule;
			shellJunctionMediator.connectModule(captionBrowserModule);
			shellJunctionMediator.sendMessage(new CaptionBrowserMessage(CaptionBrowserMessage.GET_UI));
			
			// --------------------------------------------
			// Connect Shell < - > LoginModule
			// --------------------------------------------
			var loginModule:LoginModule = new LoginModule;
			shellJunctionMediator.connectModule(loginModule);
			shellJunctionMediator.sendMessage(new LoginMessage(LoginMessage.GET_UI));
			
			// --------------------------------------------
			// Connect Shell < - > BasketModule
			// --------------------------------------------
			var basketModule:BasketModule = new BasketModule;
			shellJunctionMediator.connectModule(basketModule);
			
			// --------------------------------------------
			// Connect Shell < - > UploadModule
			// --------------------------------------------
			var uploadModule:AlbumManagerModule = new AlbumManagerModule;
			shellJunctionMediator.connectModule(uploadModule);
			
			// --------------------------------------------
			// Connect Shell < - > ViewerModule
			// --------------------------------------------
			var viewerModule:ViewerModule = new ViewerModule;
			shellJunctionMediator.connectModule(viewerModule);

			// ----------------------------
			// Plumbed!
			// ----------------------------
			sendNotification( StateMachine.ACTION, null, ShellConstants.PLUMBED );
		}
	}
}