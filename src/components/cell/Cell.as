package components.cell
{
	import flash.display.Sprite;
	import flash.events.Event;
    import model.CellVO;
    import flash.geom.Matrix;    
	import com.greensock.TweenMax;
	
	public class Cell extends Sprite 
	{		
		private var _cellVO:CellVO;			
		
		public function Cell(vo:CellVO):void
		{	
		    _cellVO = vo;
			addEventListener(Event.ADDED_TO_STAGE, init);
			drawCell(.7);
		}
		
		private function init(event:Event):void 
		{	
		    removeEventListener(Event.ADDED_TO_STAGE, init);
		    //TweenMax.to(this, 3, {delay:Math.random() * 3, scaleX:.8, scaleY:.8, yoyo:true, repeat:-1})   
		    //TweenMax.from(this, 1, {scaleX:.1, scaleY:.1})    
		}
		
		public function get cellVO():CellVO
		{
		    return _cellVO;
		}
		
		public function drawCell(opacity:Number):void
		{
		    var radius:Number = _cellVO.radius;
		    var color:Number = _cellVO.color;
			var pMatrix:Matrix = new Matrix();
			pMatrix.createGradientBox(2*radius, 2*radius, 0, 0-radius-radius/10, 0-radius-radius/10);
			
			graphics.clear();
			graphics.lineStyle(_cellVO.lineThickness, 0xffffff, .1)
			graphics.beginGradientFill(flash.display.GradientType.RADIAL, [color,color], [.7,.5], [0x00,0xff], pMatrix);
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
		}
		
		public function collidesWith(sh:Sprite):Boolean
		{
			var distance:Number = Math.sqrt( (x - sh.x) * (x - sh.x) + (y - sh.y) * (y - sh.y) );			
			
			if (distance <= width / 2 + sh.width / 2) 
				return true;			
			else
				return false;
		}
		
		public function destroy():void
		{
		    TweenMax.killTweensOf(this);
		}
	}
}
