package com.captionmashup.modules.album.facebook.model.dto
{
	import com.captionmashup.common.model.foreign.AbstractAccount;
	import com.captionmashup.modules.album.facebook.facade.ApplicationConstants;
	
	public class Friend extends AbstractAccount
	{
		public function Friend(obj:Object)
		{
			super(obj.id, obj.name, ApplicationConstants.NETWORK_NAME);
		}
	}
}