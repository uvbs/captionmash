package com.captionmashup.common.model.proxy.FrameProxy
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.captionmashup.common.model.local.vo.Frame.Frame;
	
	import flash.system.LoaderContext;
	
	import mx.collections.ArrayCollection;

	public interface IFrameProxy
	{
		function set frames(source:ArrayCollection):void;
		function get frames():ArrayCollection;
		
		function set activeIndex(value:int):void;
		function get activeIndex():int;

		/********************************
		 * Frame index stepper functions
		 * They make use of sendActiveFrame()
		 * *******************************/
		function nextFrame():void;
		function prevFrame():void;
		
		/****************************
		 * Sends notification as
		 * current active frame as body
		 * *************************/
		function sendActiveFrame():void;
		
		/****************************
		 * Adds a frame to the frames
		 * ***************************/
		function addFrame(frame:Frame,index:int=0):void;
		
		/****************************
		 * Remove frame at given index
		 * ****************************/
		function removeFrame(index:int):void;
		
	}
}