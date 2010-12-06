package com.captionmashup.common.view.mediator.CaptionViewerMediator
{
	import com.captionmashup.common.model.local.vo.Frame.Frame;
	import com.captionmashup.common.view.component.CaptionCanvas.Container.BitmapContainer;
	import com.captionmashup.common.view.component.CaptionCanvas.Container.CaptionContainer;
	
	import flash.display.BitmapData;

	public interface ICaptionViewerMediator
	{
		/********************************************
		 * Function that creates new frame display
		 * using the <imageData>,<captions>,<objects>
		 * <imageFilters> functions
		 * ******************************************/
		function set activeFrame(frame:Frame):void;
		
		/*******************************************
		 * editMode defines the context in which
		 * editor objects (captionPanel,objectPanel etc)
		 * or viewers (caption,object) will be created
		 * *****************************************/
		function set editMode(value:Boolean):void;
		
		/*******************************************
		 * Sets image using the frame.bitmapData
		 * The canvas (and its containers) will be 
		 * streched if image height is larger than 
		 * CAPTION_CANVAS_HEIGHT_SCALE_LIMIT
		 * *******************************************/
		function set imageData(bitmapData:BitmapData):void;
		
		/*******************************************
		 * Creates captions (editMode = false) 
		 * or captionPanels (editMode = true)
		 * using frame.captions
		 * ******************************************/
		function set captions(source:Array):void;
		
		/*********************************************
		 * Creates objects (editMode = false) 
		 * or objectPanels (editMode = true)
		 * using frame.objects
		 * ******************************************/
		function set propObjects(source:Array):void;
		
		/******************************************
		 * Creates 
		 * image transformations (editMode = false) 
		 * transformationPanels  (editMode = true)
		 * ******************************************/
		function set filters(filters:Array):void;
		
		/************************************************
		 * Returns viewComponent.canvas.captionContainer
		 * *********************************************/
		function get captionContainer():CaptionContainer;
		
		/*************************************************
		 * Returns viewComponent.canvas.bitmapContainer
		 * **********************************************/
		function get bitmapContainer():BitmapContainer;
		
	}
}