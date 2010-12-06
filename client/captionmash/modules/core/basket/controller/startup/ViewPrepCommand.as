package com.captionmashup.modules.core.basket.controller.startup
{
	
	import com.captionmashup.common.view.component.ThumbnailTileList.ThumbnailTileList;
	import com.captionmashup.modules.core.basket.view.BasketContainerMediator;
	import com.captionmashup.modules.core.basket.view.BasketJunctionMediator;
	import com.captionmashup.modules.core.basket.view.PhotoBasketMediator;
	import com.captionmashup.modules.core.basket.view.components.BasketContainer.BasketContainer;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			trace("BASKETMODULE VIEWPREP COMMAND CALLED");
			var basketContainer:BasketContainer = new BasketContainer;
			basketContainer.initialize();
			basketContainer.photoBasket.initialize();
			basketContainer.photoBasket.paginator.initialize();
			
			
			facade.registerMediator(new BasketContainerMediator(basketContainer));
			facade.registerMediator(new PhotoBasketMediator(basketContainer.photoBasket));
			
			facade.registerMediator(new BasketJunctionMediator());
		}
	}
}