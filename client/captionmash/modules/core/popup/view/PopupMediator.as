package com.captionmashup.modules.core.popup.view
{
	import com.captionmashup.modules.core.popup.facade.ApplicationConstants;
	
	import flash.display.DisplayObject;
	
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class PopupMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PopupMediator";
		
		public function PopupMediator()
		{
			super(NAME, null);
		}
		
		/**********************************************
		 * NOTIFICATION HANDLERS
		 * ********************************************/
		
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.CREATE_POPUP,
				ApplicationConstants.CREATE_MODAL_POPUP,
				ApplicationConstants.REMOVE_POPUP,
			];
		}
		
		override public function handleNotification(note:INotification):void
		{
			var popupBody:IFlexDisplayObject = note.getBody() as IFlexDisplayObject;
			var mainApp:DisplayObject = FlexGlobals.topLevelApplication.appScreen as DisplayObject;
			
			switch (note.getName())
			{	
				case ApplicationConstants.CREATE_POPUP:
					trace("creating popup in PopupMediator: "+note.getBody());
					PopUpManager.addPopUp(popupBody,mainApp);
					PopUpManager.centerPopUp(popupBody);
					break;
				case ApplicationConstants.CREATE_MODAL_POPUP:
					trace("creating popup in PopupMediator: "+note.getBody());
					PopUpManager.addPopUp(popupBody,mainApp,true);
					PopUpManager.centerPopUp(popupBody);
					break;
				case ApplicationConstants.REMOVE_POPUP:
					PopUpManager.removePopUp(popupBody);
					break;
			}
		}//handleNotification end
	}
}