package com.captionmashup.common.view.mediator.PaginatorMediator
{
	import com.captionmashup.common.model.local.paginator.PaginatorData;
	import com.captionmashup.common.model.proxy.PaginatorProxy.IPaginatorProxy;
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.common.view.component.Paginator.Paginator_Component;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.controls.listClasses.ListBase;
	
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	import spark.components.List;
	
	/*******************************************************
	 * Mediator Template Class which has a Paginator_Component
	 * in view and connects that component to the paginatorProxy
	 * automatically.
	 * 
	 * Usage:
	 * 
	 * 1- Paginator_Component must be named "paginator"
	 * 2- Proxy:IPaginatorProxy must be retrieved/registered in 
	 * overridden onRegister function
	 * 3- updateView function must be called inside handle block
	 * of corresponding paginator notification
	 * 
	 * 
	 * ******************************************************/
	public class AbstractPaginatorMediator extends Mediator implements IPaginatorMediator
	{
		
		protected var paginatorProxy:IPaginatorProxy;
		protected var popupMessage:PopupMessage;

		public function AbstractPaginatorMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			viewComponent.initialize();
			viewComponent.paginator.initialize();
			viewComponent.paginator.addEventListener(Paginator_Component.PREV,paginatorHandler);
			viewComponent.paginator.addEventListener(Paginator_Component.NEXT,paginatorHandler);
		}
		
		override public function onRegister():void{
			throw new Error("onRegister function of AbstractPaginatorMediator must be overridden to retrieve paginatorProxy");
		}
		
		/********************************
		 * Shell Communication
		 * ******************************/
		protected function sendMessageToShell(message:Message):void{
			throw new Error("sendMessageToShell function must be overridden");
		}
		
		/**********************************
		 * Popup Event Handlers
		 * ********************************/
		protected function createPopup(obj:Object,is_modal:Boolean = false):void{
			trace("Creating popup in AbstractPaginatorMediator");
			
			var msg_type:String = is_modal ? PopupMessage.CREATE_MODAL_POPUP : PopupMessage.CREATE_POPUP; 
			
			popupMessage = new PopupMessage(msg_type,obj);
			sendMessageToShell(popupMessage);
		}
		
		protected function removePopup(obj:Object):void{
			popupMessage = new PopupMessage(PopupMessage.REMOVE_POPUP,obj);
			sendMessageToShell(popupMessage);
		}
		
		/*************************************
		 * Paginator Event Handlers
		 * ***********************************/
		public function paginatorHandler(evt:Event):void{
			switch (evt.type)
			{
				case Paginator_Component.NEXT:
					paginatorProxy.nextPage();
					break;
				case Paginator_Component.PREV:
					paginatorProxy.prevPage();
					break;
			}
		}

		//Model === Notification(DATA) ==> Component
		public function updateView(paginatorData:PaginatorData,
								   listComponent:ListBase):void{	
			
			listComponent.dataProvider = paginatorData.items;
			viewComponent.paginator.setStatus(paginatorData);
		}
		
		public function updateSparkView(paginatorData:PaginatorData,
											listComponent:List):void{
			listComponent.dataProvider = new ArrayCollection(paginatorData.items);
			viewComponent.paginator.setStatus(paginatorData);
		}
	}
}