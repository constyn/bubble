package components.fight 
{
	import components.cell.Body;
	import config.Config;
	import flash.display.Sprite;
	import model.EntityVO;
	import utils.Draw;
	/**
	 * ...
	 * @author 
	 */
	public class Avatar extends Sprite
	{		
		private var entityVO:EntityVO;
		
		public function Avatar(vo:EntityVO) 
		{
			entityVO = vo;
			draw();
		}
		
		public function draw():void 
		{
			Draw.drawRoundRect(this,0, 0, 90, 90, 5, Config.C1, 1)
			Draw.drawRoundRect(this,5, 5, 80, 80, 4, 0x00, .3)
			
			var body:Body = new Body(entityVO)
			addChild(body);
			body.scaleX = body.scaleY =  Math.min(1, Math.min(1 / body.width, 1 / body.height))
			body.x = 45;
			body.y = 45;			
		}
	}

}