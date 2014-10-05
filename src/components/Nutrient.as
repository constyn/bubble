package components
{
	import flash.display.Sprite;
	import flash.events.Event;
    import config.Config;
    import model.*;
    import flash.geom.Matrix;    
	import com.greensock.TweenMax;
	import flash.display.LineScaleMode;
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import events.GameEvent;
	
	public class Nutrient extends Sprite 
	{		
		private var _nutriVO:NutrientVO;			
		
		public function Nutrient(vo:NutrientVO):void 
		{	
		    _nutriVO = vo;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void 
		{	
		    removeEventListener(Event.ADDED_TO_STAGE, init);
		    drawCell();		       
		}
		
		public function drawCell():void
		{
		    var radius:Number = _nutriVO.radius;
		    var color:Number = _nutriVO.color;
			var pMatrix:Matrix = new Matrix();
			pMatrix.createGradientBox(2*radius, 2*radius, 0, 0-radius-radius/10, 0-radius-radius/10);
	
			graphics.clear();
			graphics.beginGradientFill(flash.display.GradientType.RADIAL, [color,color], [1,1], [0x00,0xff], pMatrix);
		    graphics.drawCircle(0,0, radius); 
			graphics.endFill();
			
			graphics.lineStyle(2, 0xFFD700, 1, false, LineScaleMode.VERTICAL, CapsStyle.NONE, JointStyle.MITER, 10);
            graphics.moveTo(-3, 3);
            graphics.lineTo(-3, -3);
            graphics.lineTo(3, 3);
            graphics.lineTo(3, -3);
            
            TweenMax.from(this, 1, {alpha:0}) 
		}
		
		public function get nutriVO():NutrientVO
		{
		    return _nutriVO;
		}
		
		public function update():void
		{
		    if(x < -Config.WIDTH || x > 2*Config.WIDTH || y < -Config.HEIGHT || y > 2*Config.HEIGHT)
		        dispatchEvent(new GameEvent(GameEvent.DISPAWN, {obj:this}, true))
		}
	}
}
