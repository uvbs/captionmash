package com.captionmashup.common.model.foreign
{
	import mx.collections.ArrayCollection;

	//Abstract class used for foreign network modules
	public class AbstractAccount implements IAccount
	{
		public var id:String; //id
		public var name:String;	 //name
		public var network:String 
		
		public function AbstractAccount(id:String,name:String,network:String)
		{
			this.id = id;
			this.name = name;
			this.network = network;
		}
		
		public function getAccountId():String{
			return this.id;
		}
	}
}