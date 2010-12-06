package com.captionmashup.common.view.mediator.PaginatorMediator
{
	import com.captionmashup.common.view.component.Paginator.Paginator_Component;
	
	import flash.events.Event;
	
	import mx.controls.listClasses.ListBase;
	
	import spark.components.List;
	import com.captionmashup.common.model.local.paginator.PaginatorData;

	public interface IPaginatorMediator 
	{
		/*************************************************
		 * updateView(PaginatorData,ListBase):void
		 * 
		 * Updates the view component paginator using the
		 * paginatorData.
		 * 
		 * Updating includes changing the page number,enabling
		 * and disabling prev and next buttons of paginator
		 * **********************************************/
		function updateView(paginatorData:PaginatorData,listComponent:ListBase):void;
		
		/**************************************************
		 * updateSparkView(PaginatorData,ListBase):void
		 * 
		 * Updates the view component paginator using the
		 * paginatorData.
		 * 
		 * Updating includes changing the page number,enabling
		 * and disabling prev and next buttons of paginator
		 * 
		 * 
		 * ************************************************/
		
		function updateSparkView(paginatorData:PaginatorData,listComponent:List):void;
		
		/**********************************************
		 * paginatorHandler(Event):void
		 * 
		 * Handles event from paginator component
		 * (PREV, NEXT), calls the corresponding page
		 * from proxy
		 * ********************************************/
		function paginatorHandler(evt:Event):void;
	
	}
}
