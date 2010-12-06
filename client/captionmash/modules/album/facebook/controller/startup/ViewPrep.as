package com.captionmashup.modules.album.facebook.controller.startup
{
	import com.captionmashup.modules.album.facebook.view.AlbumBrowserMediator;
	import com.captionmashup.modules.album.facebook.view.AlbumMediator;
	import com.captionmashup.modules.album.facebook.view.AppScreenMediator;
	import com.captionmashup.modules.album.facebook.view.FacebookJunctionMediator;
	import com.captionmashup.modules.album.facebook.view.FriendMediator;
	import com.captionmashup.modules.album.facebook.view.PhotoMediator;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrep extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("FACEBOOK VIEWPREP COMMAND CALLED");
			
			var app:Facebook = notification.getBody() as Facebook;
			
			facade.registerMediator(new AlbumMediator(app.appScreen.albumBrowser.albums));
			facade.registerMediator(new PhotoMediator(app.appScreen.albumBrowser.photos));
			facade.registerMediator(new FriendMediator(app.appScreen.albumBrowser.friendsList));
			//facade.registerMediator(new AlbumBrowserMediator(app.appScreen.albumBrowser));
			facade.registerMediator(new AppScreenMediator(app.appScreen));
			facade.registerMediator(new FacebookJunctionMediator());
			// Create and Register the SimpleModule Junction and its Mediator
			//facade.registerMediator( new CreatorJunctionMediator() );
			//
			// Create and Register the Module and its Mediator
			//var app: SimpleModule = note.getBody() as SimpleModule;
			//facade.registerMediator( new CreatorMediator( app ) );
		}
	}
}