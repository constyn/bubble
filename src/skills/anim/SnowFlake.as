package skills.anim {
	import config.Config;
	import flash.display.Sprite;
	/**
	 * @author taires
	 */
	 


	public class SnowFlake extends Sprite
	{	
		private const SCALE:Number = 1.3;
		private var aX:Number;
		private var aY:Number;
		private var bX:Number;
		private var bY:Number;
		private var cX:Number;
		private var cY:Number;
			
		public function SnowFlake()
		{
			aX = Math.random()*SCALE+SCALE; // (10-20)
			aY = Math.random()*2*SCALE+6*SCALE; // (60-80)
			bX = Math.random()*SCALE; // (0-10)
			bY = Math.random()*2*SCALE+4*SCALE; // (40-60)
			cX = Math.random()*SCALE+SCALE; // (10-20)
			cY = Math.random()*2*SCALE+2*SCALE; // (20-40)
		
			for(var ang:int = 0; ang <= 300; ang += 60)
			{
				var spr:Sprite = new Sprite();
				drawFlake(spr);
				addChild(spr)
				spr.rotation = ang;
			}
		}
		
		private function drawFlake(mc:Sprite):void
		{
			mc.graphics.beginFill(Config.C6, .7);
			mc.graphics.lineTo(0, 8*SCALE);
			mc.graphics.lineTo(aX, aY);
			mc.graphics.lineTo(bX, bY);
			mc.graphics.lineTo(cX, cY);
			mc.graphics.lineTo(0, 0);
			mc.graphics.lineTo(0, 8*SCALE);
			mc.graphics.lineTo(-aX, aY);
			mc.graphics.lineTo(-bX, bY);
			mc.graphics.lineTo(-cX, cY);
			mc.graphics.lineTo(0, 0);
			mc.graphics.endFill(); 
		}
	}
}
	
	
