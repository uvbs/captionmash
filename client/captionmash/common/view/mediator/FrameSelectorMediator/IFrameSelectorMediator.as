package com.captionmashup.common.view.mediator.FrameSelectorMediator
{
	import com.captionmashup.common.view.component.FrameSelector.FrameSelector;
	
	import flash.events.Event;
	
	import mx.collections.IList;

	import spark.events.IndexChangeEvent;

	public interface IFrameSelectorMediator
	{
		/*********************************
		 * View component
		 * ******************************/
		function get frameSelector():FrameSelector;
		
		/********************************************
		 * EVENT HANDLER (Event)
		 * 
		 * Handles FrameSelector.NEXT and 
		 * FrameSelector.PREV events by calling
		 * the related functions from the IFrameProxy
		 * 
		 * It makes use of callNextFrame() and
		 * callPrevFrame() functions
		 * *****************************************/
		function frameSelectorHandler(evt:Event):void;
		
		//Calls next frame from proxy
		function callNextFrame():void;
		
		//Calls previous frame from proxy
		function callPrevFrame():void;
			
		/*******************************************
		 * EVENT HANDLER (IndexChangeEvent)
		 * 
		 * Handles the IndexChangeEvent when user
		 * clicks on a thumbnail in FrameSelector
		 * component.
		 * *****************************************/
		function frameIndexChangeHandler(evt:IndexChangeEvent):void;
		
		/*******************************************
		 * Sets FrameSelector.list.dataprovider
		 * to the passed value
		 * *****************************************/
		function updateFrames(list:IList):void;
		
		/*******************************************
		 * Remove all frames
		 * *****************************************/
		function clearFrames():void;
		
		/******************************
		 * Plays frames one by one
		 * using a timer and dataProvider
		 * ****************************/
		function play():void;
		
	}
}