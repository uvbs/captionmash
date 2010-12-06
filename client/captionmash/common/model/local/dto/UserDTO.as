package com.captionmashup.common.model.local.dto
{
	[RemoteClass(alias="com.captionmashup.common.model.local.dto.UserDTO")]
	[Bindable]
	public class UserDTO
	{
		//Most of the variable won't be required, possibly can use it for future,
		//make sure to use correct data types
		public var django_id:int;
		public var username:String;
		public var nickname:String;
		public var email:String;
		public var date_joined:String;
		public var groups:String;
		public var is_active:Boolean;
		public var is_staff:Boolean;
		public var is_superuser:Boolean;
		public var last_login:String;
		public var user_permissions:String;
		
		public var thumb_path:String;
		public var photo_path:String;
	}
}
