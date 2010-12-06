package com.captionmashup.common.model.local.paginator
{
	public class PaginatorData extends Object
	{
		private var _pageNo:int;
		private var _maxPages:int;
		private var _items:Array;
		private var _status:String;
		
		
		public function PaginatorData(pageNo:int = 0, maxPages:int = 0,items:Array = null,status:String = "")
		{
			super();
			this._pageNo = pageNo;
			this._maxPages = maxPages;
			this._items = items;
			this._status = status;
		}
		
		public function get status():String{
			return _status;
		}
		
		public function get max_pages():int{
			return _maxPages;
		}
		
		public function get items():Array{
			return _items;
		}
		
		public function get page_no():int{
			return _pageNo;
		}

		
	}
}