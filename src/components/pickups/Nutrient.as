package components.pickups {
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
		    var radius:Number = 10;
		    var color:Number = Config.C5;
			var pMatrix:Matrix = new Matrix();
			pMatrix.createGradientBox(2*radius, 2*radius, 0, 0-radius-radius/10, 0-radius-radius/10);
			
			graphics.clear();
			graphics.lineStyle(2, 0xffffff, Config.CELL_BORDER_OPACITY)
			graphics.beginGradientFill(flash.display.GradientType.RADIAL, [color,color], [Config.CELL_OPACITY,Config.CELL_OPACITY], [0x00,0xff], pMatrix);
			graphics.drawCircle(0,0, radius);
			graphics.endFill();
			
			graphics.lineStyle(0, color, .2)
			pMatrix.createGradientBox(2*radius/3, 2*radius/3, 0, -radius/3-(radius/3)-(radius/3)/10, -radius/3-(radius/3)-(radius/3)/10);			
			graphics.beginGradientFill(flash.display.GradientType.RADIAL, [0xffffff,0xffffff], [.2,0], [0x00,0xff], pMatrix);
			graphics.drawCircle(-radius/3, -radius/3, radius/3);
			graphics.endFill();
			
			pMatrix.createGradientBox(2*radius/10, 2*radius/10, 0,radius/3-(radius/10)-(radius/10)/10, radius/3-(radius/10)-(radius/10)/10);			
			graphics.beginGradientFill(flash.display.GradientType.RADIAL, [0xffffff,0xffffff], [.2,0], [0x00,0xff], pMatrix);
			graphics.drawCircle(radius/3, radius/3, radius/10);
			graphics.endFill();
			
			graphics.lineStyle(2, 0xFFD700, 1, false, LineScaleMode.VERTICAL, CapsStyle.NONE, JointStyle.MITER, 10);
            graphics.moveTo(-3, 3);
            graphics.lineTo(-3, -3);
            graphics.lineTo(3, 3);
            graphics.lineTo(3, -3);
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
