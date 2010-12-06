package com.captionmashup.common.view.bubble
{
	import mx.controls.Button;

	public class PanelButton extends Button{

		
		public function PanelButton(label:String,size:Number,tip:String,repeat:Boolean,styleName:String = "")
		{
			this.label = label;
			this.labelPlacement = "Left";
			//this.buttonSize = size;
			this.width = size;
			this.height = size;
			this.autoRepeat = repeat;
			this.toolTip = tip;
			this.mouseFocusEnabled = false;
			this.stickyHighlighting = true;
			this.styleName = styleName;
		}

	}
}

