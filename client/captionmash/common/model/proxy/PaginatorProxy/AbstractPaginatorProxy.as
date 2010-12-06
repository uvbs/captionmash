package com.captionmashup.common.model.proxy.PaginatorProxy
{
	import com.captionmashup.common.model.local.paginator.Paginator;
	import com.captionmashup.common.model.local.paginator.PaginatorEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	/*******************************************************
	 * Proxy template class which has a Paginator as data
	 * component and is connected to it by default
	 * 
	 * 1- Supply a unique proxy name to the constructor
	 * 2- Override pageHandler method to send corresponding
	 * paginator notification
	 * *****************************************************/
	public class AbstractPaginatorProxy extends Proxy implements IPaginatorProxy
	{
		protected var paginator:Paginator;
		protected var content:Object;
		
		public function AbstractPaginatorProxy(proxyName:String=null)
		{
			paginator = new Paginator(null,4);
			super(proxyName, paginator);
			
			paginator.addEventListener(PaginatorEvent.PAGE_EVENT,pageHandler);
		}
	
		public function setPaginator(source:Array,
									 pageSize:int=0,sortField:String="",
									 isSortNumeric:Boolean=false):void{
			
			paginator.setPaginator(source,pageSize,sortField,isSortNumeric);
		}
		
		public function get allRecords():ArrayCollection{
			return paginator.allRecords;
		}
		
		/*******************************
		 * ActiveContent Methods
		 * *****************************/
		public function set activeContent(obj:Object):void{
			this.content = obj;
		}
		
		public function get activeContent():Object{
			return content;
		}
		
		/*******************************
		 * Paginator Methods
		 * ****************************/
		public function nextPage():void
		{
			paginator.next();
		}
		
		public function prevPage():void
		{
			paginator.prev();
		}
		
		public function currPage():void
		{
			paginator.curr();
		}
		
		public function addElement(obj:Object):void{
			paginator.addElement(obj);
		}
		
		public function removeElementAt(index:int):void{
			paginator.removeElementAt(index);
		}
		
		public function set pageSize(value:int):void{
			paginator.page_size = value;
		}
		
		//This method should be overriden for each different proxy
		public function pageHandler(evt:PaginatorEvent):void
		{
			throw new Error("pageHandler must be overridden to send corresponding paginator notification from AbstractPaginatorProxy");
		}
	}
}