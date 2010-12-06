package com.captionmashup.common.view.bubble
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	internal class BubbleTail extends Sprite
	{
		private var tailType:uint = 0;
		private var tailColor:uint = 0xFFFFFF;
		private var tailOutlineColor:uint = 0x000000;
		private var lineStyle:uint = 5;
		private var isTailCurve:Boolean = false;
		
		private var circleCenter:Point = new Point(0,0);
		private var tailCenter1:Point = new Point;
		private var tailCenter2:Point = new Point;
		private var circleArray:Array = new Array;
		//private var circleRadius:Number = 15;
		
		private const CENTER_RADIUS:Number = 15;
		private const TAIL_CURVE_POINT_INTERPOLATION_RATIO:Number = 0.6;
		private var tailEndPoint:Point = new Point(150,150)
		private var tailCurvePoint:Point = new Point(0,0);
				
		private var tailOutline:Sprite = new Sprite;
		private var tailInside:Sprite = new Sprite;   
		
		
		
		public function BubbleTail(centerX:Number,centerY:Number,tailEndPointX:Number,tailEndPointY:Number,tailCurvePointX:Number,tailCurvePointY:Number,isTailCurve:Boolean,type:uint,color:uint,outlineColor:uint,outlineThickness:uint)
		{			
			super();
			
			tailColor =  color;
			tailOutlineColor = outlineColor;
			lineStyle = outlineThickness; 
			tailType = type;
			
			var p:Point = new Point(centerX,centerY);
			var tailEndPoint:Point = new Point(tailEndPointX,tailEndPointY);
			var tailCurvePoint:Point = new Point(tailCurvePointX,tailCurvePointY);
			this.setCenter(p);
			this.setTailEndPoint(tailEndPoint);
			
			
			//ellipse bubble
			if(isTailCurve == true){
				this.setTailCurvePoint(tailCurvePoint);
				drawCurve();
			}else{
				draw();	
			}
									
		}
		
		public function draw():void{
			if(this.tailType == 2){
				this.drawThoughtTail();
			}else{
				drawTail();
				drawTailOutline();	
				
			}
			isTailCurve = false;
		}
		
		public function drawCurve():void{
			if(this.tailType == 2){
				this.drawThoughtTail();
			}else{
				this.drawTailCurve();
				this.drawTailCurveOutline();
			}
			isTailCurve = true;
		}
		
		public function setCenter(p:Point):void{
			this.circleCenter = p;
			this.calculateCircle();
		}
		
		public function setTailEndPoint(p:Point):void{
			this.tailEndPoint = p;
			setTailCurvePoint(Point.interpolate(tailEndPoint,circleCenter,this.TAIL_CURVE_POINT_INTERPOLATION_RATIO));
		}
		
		public function setTailCurvePoint(p:Point):void{
			this.tailCurvePoint = p;
		}	
		
		public function getTailEndPoint():Point{
			return this.tailEndPoint;
		}	
		
		public function getTailCurvePoint():Point{
			return this.tailCurvePoint;
		}
		
		//DRAW FUNCTIONS FOR BUBBLE TAIL 
		//draws outline and inside 
		
		//P as tail END POINT
		private function drawTail():void{
			
			var ang:Number = 0; 
			ang = findAngle(circleCenter,tailEndPoint);
			this.setTailCenters(ang);
			
			tailInside.graphics.clear();
			tailInside.graphics.beginFill(tailColor);
			tailInside.graphics.lineStyle(0,tailColor);
			tailInside.graphics.moveTo(tailCenter1.x,tailCenter1.y);
			tailInside.graphics.lineTo(tailCenter2.x,tailCenter2.y);
			tailInside.graphics.lineTo(tailEndPoint.x,tailEndPoint.y);
			tailInside.graphics.lineTo(tailCenter1.x,tailCenter1.y);
			tailInside.graphics.endFill();
		}
		private function drawTailOutline():void{
			var ang:Number = 0; 
			ang = findAngle(circleCenter,tailEndPoint);
			this.setTailCenters(ang);
			
			tailOutline.graphics.clear();
			tailOutline.graphics.lineStyle(lineStyle,tailOutlineColor);
			tailOutline.graphics.moveTo(tailCenter1.x,tailCenter1.y);
			tailOutline.graphics.lineTo(tailEndPoint.x,tailEndPoint.y);
			tailOutline.graphics.lineTo(tailCenter2.x,tailCenter2.y);
		}
				
		//P as tail curve CONTROL POINT
		private function drawTailCurve():void{
			
			var ang:Number = 0; 
			ang = findAngle(circleCenter,tailCurvePoint);
			this.setTailCenters(ang);
			
					
			tailInside.graphics.clear();
			tailInside.graphics.beginFill(tailColor);
			tailInside.graphics.lineStyle(0,tailColor);
			tailInside.graphics.moveTo(tailCenter1.x,tailCenter1.y);
			tailInside.graphics.lineTo(tailCenter2.x,tailCenter2.y);
			tailInside.graphics.curveTo(tailCurvePoint.x,tailCurvePoint.y,tailEndPoint.x,tailEndPoint.y);
			tailInside.graphics.curveTo(tailCurvePoint.x,tailCurvePoint.y,tailCenter1.x,tailCenter1.y);
			tailInside.graphics.endFill();
		}
		
		private function drawTailCurveOutline():void{
			
			var ang:Number = 0; 
			ang = findAngle(circleCenter,tailCurvePoint);
			this.setTailCenters(ang);
						
			tailOutline.graphics.clear();
			tailOutline.graphics.lineStyle(lineStyle,tailOutlineColor);
			tailOutline.graphics.moveTo(tailCenter1.x,tailCenter1.y);
			tailOutline.graphics.curveTo(tailCurvePoint.x,tailCurvePoint.y,tailEndPoint.x,tailEndPoint.y);
			tailOutline.graphics.curveTo(tailCurvePoint.x,tailCurvePoint.y,tailCenter2.x,tailCenter2.y);
		}
		
		//DRAW FUNCTION FOR THOUGHT BUBBLE
		private function drawThoughtTail():void{
			//for(var i:Number = 0; i < 1, i=i+0.15){
			var p:Point = new Point; 
			
			clearTail();
					
			tailOutline.graphics.lineStyle(lineStyle,tailOutlineColor);
			tailInside.graphics.beginFill(tailColor);
			tailInside.graphics.lineStyle(0,tailColor);						
			
			
			for(var i:Number = 0; i < 1; i=i+0.20){
				p = getPointOnBezier(i,this.tailEndPoint,this.tailCurvePoint,this.circleCenter);
				tailOutline.graphics.drawCircle(p.x,p.y,5+i*10);
				tailInside.graphics.drawCircle(p.x,p.y,5+i*10);	
			}
			
			tailOutline.graphics.endFill();
			tailInside.graphics.endFill();
					
		}		
		//calculates circle points for drawing tail triangle
		private function calculateCircle():void{
			
			var steps:uint = 360;
			var rad:Number = CENTER_RADIUS;
			
			//delete array
			this.circleArray.splice(0);
			for(var i:int = 0; i < 360; i+= 360/steps){
							
				var alpha:Number = i * (Math.PI /180);
				var sinAlpha:Number = Math.sin(alpha);
			 	var cosAlpha:Number = Math.cos(alpha);
			 	
			 	var circX:Number = circleCenter.x + (rad * cosAlpha);
			 	var circY:Number = circleCenter.y + (rad * sinAlpha);
			 	
			 	var  p:Point = new Point(circX,circY);
			 	this.circleArray.push(p);
				
			}			
		}
		
		//p1= center of circle
		//p2= target point
		//find angle between point 1, point 2 and y=0 line and returns degree value
		private function findAngle(p1:Point,p2:Point):Number{
			
			var rad:Number = 0;
			var angle:Number = 0;
				
			if(p2.x - p1.x == 0 || p1.x - p2.x == 0){
				angle = -90
				
			}else{
				rad = Math.atan((p2.y-p1.y)/(p2.x-p1.x));	
				angle = Math.floor((rad * (180/Math.PI)));
				
			}		
			
			return angle;
		}

		private function setTailCenters(angle:int):void{
			
			var index:int = angle + 90;
			this.tailCenter1 = this.circleArray[index];
			this.tailCenter2 = this.circleArray[index+180];
			
		}
		
		//USED FOR RESCALING
		public function setTail(p:Point):void{
			
			
			this.setCenter(p);
			
			var endX:Number = this.circleCenter.x * 1.6;
			var endY:Number = this.circleCenter.y * 2 + 50;
			
			var pt:Point = new Point(endX,endY);
			
			this.setTailEndPoint(pt);
			
			draw();
		}

		

		
		private function getPointOnBezier( t:Number, p0:Point, p1:Point, p2:Point ) : Point {
		    t = Math.max( Math.min( 1, t ), 0 );
		    var tSq:Number = t * t;
		    var diff:Number = 1 - t;    
		    var diffSq:Number = diff * diff;    
		    diff *= 2 * t; //don't need to recalculate this for x and y    
		    var point:Point = new Point();
		    point.x = diffSq * p0.x + diff * p1.x + tSq * p2.x;
		    point.y = diffSq * p0.y + diff * p1.y + tSq * p2.y;
		    return point;
		}
		/*
		RETURN FUNCTIONS FOR TAIL VALUES:
		Inside of tail (white region)
		Tail Outline
		*/
		public function getTailInside():Sprite{
			return this.tailInside;
		}
		
		public function getTailOutline():Sprite{
			return this.tailOutline;
		}
		
		public function clearTail():void{
			this.tailInside.graphics.clear();
			this.tailOutline.graphics.clear();
		}
		
		public function setTailType(value:uint,showTail:Boolean):void{
			this.tailType = value;
			if(showTail){
				if(isTailCurve)
				{
					drawCurve();
				}else{
					draw();	
				}	
			}
			
			
		}
		public function getTailType():uint{
			return this.tailType;
		}
		
		public function getIsCurve():Boolean{
			return this.isTailCurve;
		}
	
	}
}