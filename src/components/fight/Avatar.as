package components.fight 
{
	import components.cell.Body;
	import config.Config;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;	
	import flash.display.PixelSnapping;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import model.EntityVO;
	import utils.Draw;
	import flash.utils.setTimeout;
	import utils.TextUtil;
	/**
	 * ...
	 * @author 
	 */
	public class Avatar extends Sprite
	{		
		private var bgBitmap:Bitmap;
		private var bgBmpd:BitmapData;
		private var entityVO:EntityVO;
		private var body:Body;
		
		public function Avatar(body:Body, entityVO:EntityVO) 
		{
			this.body = body;
			this.entityVO = entityVO;
			draw();
		}
		
		public function draw():void 
		{
			Draw.drawRoundRect(this, 0, 0, 90, 90, 5, Config.C1, 1);
			Draw.drawRoundRect(this, 5, 5, 80, 80, 4, 0x00, .4);			
			
			setTimeout(updateSize, 100);
		}
			
		private function updateSize():void 
		{			
			var scale:Number =  Math.min(1, Math.min(78 / body.width, 78 / body.height))
			
			bgBmpd = new BitmapData(80, 80, true, 0x000000) ;
			bgBitmap = new Bitmap(bgBmpd, PixelSnapping.NEVER, false);       
			bgBitmap.x = 5;
			bgBitmap.y = 5;
			
			var pMatrix:Matrix = new Matrix();
			pMatrix.scale(scale, scale);
			pMatrix.translate(40, 40);
            bgBmpd.draw(body, pMatrix, null, null, null, false);
            addChild(bgBitmap); 	
			
			var levelText:TextField = TextUtil.createText({color:0x222222, contour:Config.C1});
			addChild(levelText);
		    levelText.x = 6;
		    levelText.y = 67;
		    levelText.text = "Lvl: " + entityVO.level;
		}
	}

}