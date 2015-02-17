package components.fight 
{
	import com.greensock.TweenMax;
	import config.Config;
	import flash.display.Sprite;
	import flash.text.TextField;
	import model.EntityVO;
	import utils.Draw;
	import utils.TextUtil;
	/**
	 * ...
	 * @author 
	 */
	public class LifeBar extends Sprite
	{
		private var life:Sprite;
		private var lifeText:TextField;
		private var entityVO:EntityVO;
		
		public function LifeBar(vo:EntityVO) 
		{
			entityVO = vo;
			draw();
		}
		
		private function draw():void
		{
			Draw.drawRoundRect(this, 0, 0, 530, 15, 4, 0x00, 0.3)
			life = new Sprite();
			Draw.drawRoundRect(life, 0, 0, 530, 15, 4, Config.C5, 1)
			life.scaleX = entityVO.currentHealth / entityVO.totalHealth;
			this.addChild(life);
			TweenMax.from(life, 1, { delay:1, scaleX:0 } );		
			
			lifeText = TextUtil.createText({color:0x111111});
			addChild(lifeText);
		    lifeText.text = "Health: " + entityVO.currentHealth;
			lifeText.y = -2;
		    this.addChild(lifeText)
		}
		
		public function update():void 
		{
			lifeText.text = "Health: " + entityVO.currentHealth;
			if(life.scaleX != entityVO.currentHealth/entityVO.totalHealth)
				TweenMax.to(life, 1, { scaleX:entityVO.currentHealth / entityVO.totalHealth } );  
		}
		
	}

}