package com.captionmashup.common.model.foreign.facebook
{
	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.common.model.foreign.AbstractAccount;
	
	public class User extends AbstractAccount
	{
		public function User(obj:Object=null)
		{
			if(obj != null){
				super(obj.id,obj.name,CommonConstants.FACEBOOK_NETWORK_NAME);
			}
		}
	}
}