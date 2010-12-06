
 package com.captionmashup.common.pipe
{
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	
	/**
	 * Pipe Aware Module interface.
	 */
	public interface IPipeAwareModule extends IPipeAware
	{
		function dispose():void;
		function getName():String;
	}
}