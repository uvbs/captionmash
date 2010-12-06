package com.captionmashup.common.view.bubble
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ScaleButton extends PanelButton
	{
		public function ScaleButton()
		{
			super();
			
		}
		
		protected override function createButtonGraphics():Sprite{
			var circle:Sprite = new Sprite();
		    circle.graphics.beginFill(0x22);
		    circle.graphics.drawCircle(0,0 ,10);
		    return circle;
		}
	
		
	
	
	
	}
}
