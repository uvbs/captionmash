package com.captionmashup.common.view.mediator.FrameSelectorMediator
{
	import com.captionmashup.common.CommonConstants;
	import com.captionmashup.common.model.proxy.FrameProxy.IFrameProxy;
	import com.captionmashup.common.view.component.FrameSelector.FrameRenderer;
	import com.captionmashup.common.view.component.FrameSelector.FrameSelector;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.IList;
	import mx.core.ClassFactory;
	
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import spark.components.List;
	import spark.events.IndexChangeEvent;
	
	public class AbstractFrameSelectorMediator extends Mediator implements IFrameSelectorMediator
	{
		protected var frameProxy:IFrameProxy;
		protected const MS_PER_FRAME:int = CommonConstants.DEBUG_MODE == true ? 1000 : 3000;
		protected var timer:Timer;

		
		public function AbstractFrameSelectorMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			
			timer = new Timer(MS_PER_FRAME);
			timer.addEventListener(TimerEvent.TIMER,onTimer);

			frameSelector.list.addEventListener(IndexChangeEvent.CHANGE,frameIndexChangeHandler);
			frameSelector.addEventListener(FrameSelector.NEXT,frameSelectorHandler);
			frameSelector.addEventListener(FrameSelector.PREV,frameSelectorHandler);
			
			frameSelector.list.itemRenderer = new ClassFactory(FrameRenderer);
		}
		
		override public function onRegister():void{
			throw new Error("onRegister function must be overridden to retrieve IFrameProxy");
		}
		
		public function get frameSelector():FrameSelector{
			return viewComponent as FrameSelector;
		}
		
		public function get dataProvider():IList{
			return frameSelector.list.dataProvider as IList;
		}
		
		public function frameSelectorHandler(evt:Event):void
		{
			if(frameSelector.list.dataProvider == null) return;
			switch (evt.type)
			{
				case FrameSelector.NEXT:
					callNextFrame();
					break;
				case FrameSelector.PREV:
					callPrevFrame();
					break;
			}
		}
		
		/****************************
		 * Frame Steppers
		 * *************************/
		public function callNextFrame():void
		{
			if(frameSelector.list.selectedIndex < dataProvider.length -1){
				frameSelector.list.selectedIndex += 1;
				frameSelector.list.ensureIndexIsVisible(frameSelector.list.selectedIndex);
				frameProxy.nextFrame();
			}
		}
		
		public function callPrevFrame():void
		{
			if(frameSelector.list.selectedIndex -1 >= 0)
			{
				frameSelector.list.selectedIndex -= 1;
				frameSelector.list.ensureIndexIsVisible(frameSelector.list.selectedIndex);
				frameProxy.prevFrame();	
			}
		}
		
		public function frameIndexChangeHandler(evt:IndexChangeEvent):void
		{
			frameProxy.activeIndex = frameSelector.list.selectedIndex;
		}
		
		//Update frames
		public function updateFrames(list:IList):void
		{
			frameSelector.list.dataProvider = list;
		}
		
		public function clearFrames():void{
			frameSelector.list.dataProvider = null;
		}
		
		/********************************
		 * Caption Player Implementation
		 * ******************************/
		//Timer event listener
		private function onTimer(evt:TimerEvent):void{		
			callNextFrame();
		}
		//Timer must be repeated Number of Frames - 1 times
		public function play():void{
			timer.reset();
			timer.repeatCount = dataProvider.length-1;
			
			//Set indexes to 0
			frameProxy.activeIndex = 0;
			frameSelector.list.selectedIndex = 0;
			
			if(dataProvider.length != 1){
				timer.start();	
			}
		}
		
		public function stop():void
		{
			timer.reset();
		}
	}
}