package com.captionmashup.common.model.local.paginator
{
	import flash.events.IEventDispatcher;

	public interface IPaginator extends IEventDispatcher
	{
		function nextPage():void;
		function prevPage():void;
		function currPage():void;
		
		function get maxPages():int;
		function set pageSize(value:int):void;
		
		function addElement(obj:Object):void;
		function removeElement(obj:Object):void;
		
	}
}