package com.captionmashup.common.model.proxy.PaginatorProxy
{
	import com.captionmashup.common.model.local.paginator.PaginatorEvent;
	
	import mx.collections.ArrayCollection;

	public interface IPaginatorProxy
	{
		function set activeContent(obj:Object):void;
		function get activeContent():Object;
		//Flips to next page in paginator
		function nextPage():void;
		
		//Flips to previous page in paginator
		function prevPage():void;
		
		//Forces current page retrieval in paginator
		function currPage():void;
		
		//Returns all records from paginator for filter function
		function get allRecords():ArrayCollection;
		
		//Default pageHandler function that sends paginator_notification, must be overridden
		function pageHandler(evt:PaginatorEvent):void;
		
		//Add single element to paginator source
		function addElement(obj:Object):void;
		
		//Remove single element from paginator source
		function removeElementAt(index:int):void;
		
		//Change pageSize
		function set pageSize(value:int):void;
	}
}