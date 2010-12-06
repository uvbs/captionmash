package com.captionmashup.common.model.local.paginator
{
	import com.captionmashup.common.log.t;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	public class AbstractPaginator implements IPaginator
	{
		protected var list:ArrayCollection;
		protected var currentPage:int;
		protected var size:int;
		protected var dispatcher:EventDispatcher;
		
		public function AbstractPaginator(source:Array,pageSize:int = 0)
		{
			this.list = new ArrayCollection(source);
			this.pageSize = pageSize;
			dispatcher = new EventDispatcher(this);
		}
		
		/******************************
		 * Paging Methods
		 * ****************************/
		public function nextPage():void{		
			if(currentPage < maxPages){
				currentPage =+ 1;
				currPage();
			}
		}
		
		public function prevPage():void{
			if(currentPage > 1){
				currentPage -= 1;
				currPage();
			}
		}
		
		/****************************************************************
		 * Main function used for creating a "page"
		 * 
		 * Uses size and list variables, to create a subarray
		 * 
		 * May be overridden to create overlapping page displays
		 * **************************************************************/
		public function currPage():void
		{
			var page:Array = list.toArray().slice(size*(currentPage-1),size*currentPage);
			t.obj(page,"Page in AbstractPaginator");
			//dispatch paginator event 
		}
		
		public function get maxPages():int
		{
			return (list.length % size > 0) ? (list.length / size) + 1 : list.length / size;
		}
		
		/***************************************************
		 * Default function that calculates how many pages 
		 * there will be in this paginator
		 * 
		 * Example: 
		 * Let's say we have a data of 19 items and paginator
		 * pageSize is set to 5
		 * 
		 * 19 % 5 = 4 => 19 / 5 = 3 => 3 + 1 = 4 pages
		 * 
		 * This function may be overridden for overlapping
		 * page displays
		 * ***********************************************/
		public function set pageSize(value:int):void
		{
			if(value < 0)
			{
				throw new Error("Paginator page size can't be smaller than zero. Passed value: "+value);
				return;
			}
			this.size = value;
			
			//Send new paginator event to refresh view
		}
		
		public function addElement(obj:Object):void
		{
		}
		
		public function removeElement(obj:Object):void
		{
		}
		
		/***************************************
		 * Event Dispatcher Methods
		 * *************************************/
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return dispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return dispatcher.willTrigger(type);
		}
	}
}