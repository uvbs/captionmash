package com.captionmashup.common.view.bubble
{
	import com.cartogrammar.drawing.CubicBezier;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	

	public class Bubble extends Sprite
	{
		private var _bubbleType:uint = 0;
		private var _bubbleColor:uint = 0xFFFFFF;
		private var _bubbleOutlineColor:uint = 0x000000;
		private var _lineStyle:uint = 0;
		private var _bubbleWidth:Number = 0;
		private var _bubbleHeight:Number = 0;
		


	
		public function Bubble(width:Number,height:Number,type:uint,color:uint,outlineColor:uint,outlineThickness:uint)
		{
			super();
		
			_bubbleColor = color;
			_bubbleOutlineColor = outlineColor;
			_lineStyle = outlineThickness;
			_bubbleWidth = width;
			_bubbleHeight = height;
			_bubbleType = type;
		
			
			draw();
					
						
		}
		
		public function draw():void{
			graphics.clear( );
			graphics.lineStyle(_lineStyle,_bubbleOutlineColor);
			graphics.beginFill(_bubbleColor, 1);
			
			switch (_bubbleType){
				case 0: //ellipse
					graphics.drawEllipse(0,0,_bubbleWidth,_bubbleHeight);
				break;				
				case 1: //rectangle
					graphics.drawRoundRect(0,0,_bubbleWidth,_bubbleHeight,10,10);
				break;
				case 2: //thought bubble
					drawThoughtBubble(_bubbleWidth,_bubbleHeight);				
				break;
				case 3:
					drawScreamBubble(_bubbleWidth,_bubbleHeight);
				break;
			
			}
		}
		
		private function drawScreamBubble(width:Number,height:Number):void{
			var points:Array = new Array;
			var pointsOuter:Array = new Array;
			
			points = calculateEllipse(width/2,height/2,width/2,height/2,10,0.5);
			pointsOuter = calculateEllipse(width/2,height/2,width*3/2, height*3/2,10,0);
							
			var p1:Point = new Point;
			var p2:Point = new Point;
			var p3:Point = new Point;

			

			
			/*
			Draw curves
			P1: Anchor 1
			P2: Control
			P3: Anchor 2
			*/
			p1 = pointsOuter[0];
			graphics.moveTo(p1.x,p1.y);								
			for(var i:int = 0; i < pointsOuter.length; i++){
				
			
				if(i == points.length-1){
					
					p1 = pointsOuter[i];
					p2 = points[i];
					p3 = pointsOuter[0];
				}else {
					p1 = pointsOuter[i];
					p2 = points[i];
					p3 = pointsOuter[i+1];
				}
				
				
				graphics.curveTo(p2.x,p2.y,p3.x,p3.y);	
			}
		}
		
		private function drawThoughtBubble(width:Number,height:Number):void{
				
					var points:Array = new Array;
					var pointsOuter:Array = new Array;
					points = calculateEllipse(width/2,height/2,width,height,10,0);
					pointsOuter = calculateEllipse(width/2,height/2,width*4/3, height*4/3,10,0);
					
					var p1:Point = new Point;
					var p2:Point = new Point;
					var p3:Point = new Point;
					var p4:Point = new Point;
					
							

					//DRAW THE FRIGGIN THOUGHT BUBBLE
					//P1, P4 inner circle, anchor points
					//P2, P3, outer cirche, control points
					
					p1= points[0];
					p2 = Point(pointsOuter[0]);
					
					graphics.moveTo(p1.x,p1.y);	
					for(var i:int = 0; i < points.length; i++){
											
												
						if(i == points.length-1){
							
							p1 = points[points.length-1];
							p2 = pointsOuter[points.length-1];
							p3 = pointsOuter[0];
							p4 = points[0];
					
						}else{
							p1 = points[i];
							p2 = pointsOuter[i];
							p3 = pointsOuter[i+1];
							p4 = points[i+1];
					
						}
							
						CubicBezier.drawCurve(this.graphics,p1,p2,p3,p4);
					}
					//DRAW INNER ELLIPSE
					graphics.lineStyle(_lineStyle,_bubbleColor);
					p1 = Point(points[0]);
					graphics.moveTo(p1.x,p1.y);
					
					for(var y:int = 0; y < points.length; y++){
						
						p2 = points[y];
						graphics.lineTo(p2.x,p2.y);
					}
					graphics.lineTo(p1.x,p1.y);
		}
		
		private function calculateEllipse(x:Number,y:Number,width:Number, height:Number,steps:uint,delta:Number):Array{
			
			if(delta < 0 || delta > 1){
				delta = 0;
			}
			var points:Array = new Array;
			delta *= (360/steps);
		//	trace("Delta: "+delta);
			
			for(var i:int = 0; i < 360; i+= 360/steps){
				
				
				
			//	trace("angle: "+Number(i+delta));
			 	var alpha:Number = (i+delta) * (Math.PI / 180);
			 	
			// 	trace("alpha: "+alpha);
			 	
			 	var sinAlpha:Number = Math.sin(alpha);
			 	var cosAlpha:Number = Math.cos(alpha);
			 	
			 	var ellipsePointX:Number = (x) +(width/2 * cosAlpha);
			 	var ellipsePointY:Number  =  (y) + (height/2 * sinAlpha);
			 	
			 	var  p:Point = new Point(ellipsePointX,ellipsePointY);
			 	
			 	points.push(p);
			 			 	
			}
			 
			return points;
			
		}
		

		
		public function setBubbleSize(width:Number,height:Number):void{
			_bubbleWidth = width;
			_bubbleHeight = height;
			draw();
		}
		
		public function toggleBubbleType():void{
			switch(_bubbleType){
				case 0:
					setBubbleType(1);
					break;
				case 1:
					setBubbleType(2);
					break;
				case 2:
					setBubbleType(3);
					break;
				case 3:
					setBubbleType(0);
					break;
			}
		}

		/**
		 *Getter and Setter for Bubble Type
		 * 0 = ellipse
		 * 1 = rectangle
		 * 2 = thought
		 * 3 = scream 
		 **/
		public function getBubbleType():uint{
			return _bubbleType;
		}
		
		public function setBubbleType(type:uint):void{
			if(type < 4)
				this._bubbleType = type;
			draw();
		}
	}
}