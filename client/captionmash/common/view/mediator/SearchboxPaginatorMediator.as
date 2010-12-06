package com.captionmashup.common.view.mediator
{
	import com.captionmashup.common.view.component.SearchBox.SearchBox;
	
	import flash.events.Event;
	import com.captionmashup.common.view.mediator.PaginatorMediator.AbstractPaginatorMediator;

	/*******************************************************
	 * Mediator Template class which both have a
	 * Paginator_Component and SearchBox. It connects
	 * Paginator_Component to the paginatorProxy
	 * as well as filtering paginator data and updating the
	 * Paginator_Component using the text entered 
	 * in the searchbox
	 * 
	 * Usage (Similar to AbstractPaginatorMediator)
	 * 
	 * 1- Paginator_Component must be named "paginator"
	 * 2- SearchBox must be named searchBox
	 * 3- Proxy:IPaginatorProxy must be registered in 
	 * overridden onRegister function
	 * 4- updateView function must be called inside handle block
	 * of corresponding paginator notification
	 * ******************************************************/
	public class SearchboxPaginatorMediator extends AbstractPaginatorMediator
	{
		protected var view_component:Object;
		
		public function SearchboxPaginatorMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			view_component = viewComponent;
			viewComponent.addEventListener(SearchBox.SEARCH_START,onSearchStart);
			viewComponent.addEventListener(SearchBox.SEARCHBOX_CLICK,onSearchTextboxClicked);	
		}
		
		
		//Search Function
		private function onSearchStart(evt:Event):void{
			if(view_component.searchBox.textInput.text.length == 0){
				paginatorProxy.allRecords.filterFunction = null;
			}
			else{
				view_component.paginator.prev.enabled = false;
				view_component.paginator.next.enabled = false;
				
				paginatorProxy.allRecords.filterFunction=nameFilter;
				view_component.list.dataProvider = paginatorProxy.allRecords;
			}
			
			paginatorProxy.allRecords.refresh();
		}
		//Filter function
		private function nameFilter(item:Object):Boolean{
			var content:String = view_component.searchBox.textInput.text.toLowerCase();
			var key:String = item.name.toLowerCase();
			
			if(key.indexOf(content)!=-1){
				return true
			}
			else{
				return false
			}
		}
		//Filter reset function
		private function onSearchTextboxClicked(evt:Event):void{
			view_component.searchBox.textInput.text = "";
			paginatorProxy.allRecords.filterFunction = null;
			paginatorProxy.allRecords.refresh();
			
			paginatorProxy.currPage();
		}
	}
}