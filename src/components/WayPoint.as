package components
{
	import config.Config;
	import flash.display.Sprite;
	import flash.events.Event;   
	import com.greensock.TweenMax;
	
	public class WayPoint extends Sprite 
	{		
				
		public function WayPoint():void
		{	
		    addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void 
		{	
		    removeEventListener(Event.ADDED_TO_STAGE, init);
		    drawCell(.5)		   
		}
		
		public function drawCell(opacity:Number):void
		{
		    var radius:Number = 1;
		    var color:Number = Config.C2
		    
		    graphics.clear();
			graphics.beginFill(color, opacity);
			graphics.drawCircle(0,0, radius);
			graphics.beginFill(color, opacity);
			graphics.drawCircle(0,0, radius - 3);
			graphics.endFill();
		}	
		
		public function update():void
		{
		}
		
		public function animate():void
		{
			TweenMax.killTweensOf(this);
		    scaleX = 10;
		    scaleY = 10;
		    alpha = 1;
		    TweenMax.to(this, .4, {scaleX:1, scaleY:1, alpha:0})
		}		
	}
}
