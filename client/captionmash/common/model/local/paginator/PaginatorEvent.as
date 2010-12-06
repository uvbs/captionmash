package com.captionmashup.common.model.local.paginator
{
	import flash.events.Event;

	public class PaginatorEvent extends Event
	{
		public var currPage:int = 0;
		public var data:PaginatorData;
		
		//Used to send standard page change
		public static const PAGE_EVENT:String    = 'PAGE_EVENT';
		
		//Sent when paginator is created (within constructor)
		public static const PAGINATOR_CREATED:String = 'PAGINATOR_CREATED';
		
		//Sent when paginator values are set 
		public static const PAGINATOR_SET:String = 'PAGINATOR_SET';
		
		//Sent when the sort function of paginator is finished
		public static const PAGINATOR_SORT_COMPLETE:String = 'PAGINATOR_SORT_COMPLETE';
		
		public function PaginatorEvent( type:String,data:PaginatorData=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
	}
}