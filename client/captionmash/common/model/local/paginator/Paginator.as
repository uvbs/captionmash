package com.captionmashup.common.model.local.paginator
{
	
	import com.captionmashup.common.log.t;
	
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	/******************************
	 * Storage and paginaton for friendsTree and thumbsTileList
	 * 
	 * 
	 * 	 * *********************************/
	public class Paginator extends EventDispatcher
	{
		private var list:ArrayCollection;
		private var subList:Array;
		private var currPage:int = 0;
		private var pages:int = 0;
		private var pageSize:int;
		
		//private var maxPages:int;
		
		public static const AT_START:String    	= 'AT_START';
        public static const AT_END:String 		= 'AT_END';
        public static const AT_MIDDLE:String 	= 'AT_MIDDLE';
		public static const EMPTY:String 		= 'EMPTY';
		
		//sorting 
		private var dataSortField:SortField;
		private var dataSort:Sort;
				
		public function Paginator(source:Array=null,pageSize:int = 0,sortField:String = "",
								  isSortNumeric:Boolean = false)
		{
			list = new ArrayCollection(source);

			this.pageSize = pageSize;
			
			if(source != null){
				currPage = 1;
				pages = max_pages;
			}
			
			if(sortField != ""){
				sort(sortField,isSortNumeric);
			}
			//this.sendEvent(PaginatorEvent.PAGINATOR_CREATED);	
			this.reportStatus();
			//trace("creating paginator, dataclass:"+ this.dataClass);
		}
		
		public function setPaginator(arr:Array, 
									 size:int = 0,sortField:String = "",
									 isSortNumeric:Boolean = false):void{
						
			this.list = new ArrayCollection(arr);
				
			this.pageSize = size == 0 ? this.pageSize : size;
	
			this.currPage = 1;
			this.pages = max_pages;
			
			if(sortField != ""){
				sort(sortField,isSortNumeric);
			}
			this.reportStatus();
		}
		
		/******************************************
		 * Method for adding 1 page to the current 
		 * paginator list, not used ATM
		 * ****************************************/
		public function addPage(arr:Array):void
		{			
			for (var i:int = 0; i < arr.length; i++)
            {
            	
            //	this.addItem(new dataClass(arr[i]));
          	}
          	this.pages +=1;
          	this.currPage = this.pages;
          	this.reportStatus();
		}
		
		public function addElement(obj:Object):void{
			this.list.addItem(obj);
			
			//Handle empty paginator
			currPage = currPage == 0 ? 1 : currPage;
			reportStatus();
		}
		
		/*************************************
		 * Removing element is tricky as 
		 * the selected index is not the real
		 * index (source) but index of subList
		 * 
		 * So we calculate by 
		 * Real index = ((currPage-1) * pageSize) + index
		 * **********************************/
		public function removeElementAt(index:int):void{
			this.list.removeItemAt(((currPage-1) * pageSize) + index);
			if(max_pages < currPage) currPage--;
			reportStatus();
		}
		
		public function get allRecords():ArrayCollection{
			return this.list;
		}
		
		public function get loadedPages():int{
			return this.pages;
		}


		
		/***********************************************
		 * Page retrieval methods
		 * *********************************************/
		public function next():void{
			if(currPage < max_pages) 
			{				
				currPage += 1;
				this.reportStatus(); //dispatch event
			}
			
		}
		
		public function prev():void{
			if(currPage > 1)
			{
				currPage -= 1;
				this.reportStatus();//dispatch event
			}	
		}
		
		public function curr():void{
			this.reportStatus();//dispatch event
		}
		
		private function get pageItems():Array{
			
			var bigList:Array =list.toArray();
			subList = bigList.slice(pageSize*(currPage-1),pageSize*currPage);
			
			return subList;	
		}
		

		/**************************************************
		 * PaginatorEvent dispatching function 
		 * ************************************************/
	    private function sendEvent(eventName:String,data:PaginatorData = null):void
        {			
			//trace("dispatching paginatorEvent: "+eventName);
			var e:PaginatorEvent = new PaginatorEvent(eventName,data,true);
			this.dispatchEvent(e);
        }
        
		
		/***************************************
		 * Sends paginator PAGE_EVENT, with current
		 * page items, page number, max pages and status
		 * Main function for sending paginator DATA
		 * *************************************/
		private function reportStatus():void{
			sendEvent(PaginatorEvent.PAGE_EVENT,this.data);
		}
		
		
		/****************************************
		 * Creating data to be sent along with
		 * Paginator Event
		 * 
		 * currentPageNumber: 	int
		 * max_pages		:	int
		 * current 			:	array
		 * status			:	string
		 * **************************************/
		private function get data():PaginatorData{
			var result:PaginatorData = new PaginatorData(this.currPage,
															this.max_pages,
															this.pageItems,
															this.status);
			
			return result;
		}
		
		public function get max_recs():int{
			return this.list.length;
		}
		
		public function get max_pages():int{
			return (max_recs % pageSize > 0) ? (max_recs/pageSize) + 1 : max_recs/pageSize;
		}
		
		public function set page_size(value:int):void{
			if(value <= 0) throw new Error("Paginator pageSize cannot be less than 1");
			this.pageSize = value;
			this.currPage = 1;
			reportStatus();
		}
		
		/***********************************
		 * Status function to determine if 
		 * NEXT and PREV buttons should be enabled
		 * included in paginator event
		 * *********************************/
		
		private function get status():String{
			var stat:String = "";
			
			if(list.length == 0){
				stat = EMPTY;
				return stat; 
			}
			
			if(currPage == 1 || currPage == 0){
				stat = AT_START;
			}else if(currPage == this.max_pages){
				stat = AT_END;
			}else{
				stat = AT_MIDDLE;
			}
			return stat;
		}
		
		/******************************************
		 * SORT METHOD
		 * takes a string as sort field name
		 * ****************************************/
		private function sort(sortField:String,isNumeric:Boolean):void{
			
			dataSortField = new SortField();
			dataSort = new Sort();
			
			dataSortField.name = sortField;
			dataSortField.numeric = isNumeric;
			dataSortField.caseInsensitive = true;
			dataSort.fields = [dataSortField];
			
			list.sort = dataSort;
			list.refresh();
			
			sendEvent(PaginatorEvent.PAGINATOR_SORT_COMPLETE,this.data);	
		}

	}
}