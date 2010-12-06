package com.captionmashup.modules.album.local.controller.startup
{
	import com.captionmashup.modules.album.local.model.AlbumProxy;
	import com.captionmashup.modules.album.local.model.GenreProxy;
	import com.captionmashup.modules.album.local.model.MemberProxy;
	import com.captionmashup.modules.album.local.model.PhotoProxy;
	import com.captionmashup.modules.album.local.model.UserProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ModelPrepCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			trace("LOCAL ALBUM MODULE ModelPrepCommand called");
			facade.registerProxy(new AlbumProxy());
			facade.registerProxy(new GenreProxy());
			facade.registerProxy(new PhotoProxy());
			facade.registerProxy(new UserProxy());
			facade.registerProxy(new MemberProxy());
		}
	}
}