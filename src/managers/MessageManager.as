package managers 
{
	import config.Config;
	import flash.filters.BlurFilter;
	import com.greensock.TweenMax;
	import utils.TextUtil;
	import flash.text.TextField;
	import flash.display.Sprite;
	/**
	 * @author taires
	 */
	public class MessageManager extends Sprite
	{
		private var msgBack:Sprite;
		private var msgText:TextField;
		
		public function MessageManager()
		{
			
		}
		
		public function showMessage(str:String):void
		{
			if(!msgBack)
			{
				msgBack = new Sprite();
				addChild(msgBack);	
			}
			
			if(!msgText)
			{
				msgText = TextUtil.createText()
				msgBack.addChild(msgText);
			}
			
			msgText.htmlText = str;
			
			msgBack.visible = true;
			msgBack.graphics.clear();
			msgBack.graphics.beginFill(0x000000, .8)
			msgBack.graphics.drawRoundRectComplex(-2, 0, msgBack.width + 4, msgBack.height, 5, 0, 0, 5)
			msgBack.x = (Config.WIDTH - msgBack.width) / 2
			
			msgBack.filters = [new BlurFilter(0,0,0)]
			msgBack.alpha = 0;
			msgBack.y = Config.HEIGHT - 100
			TweenMax.killTweensOf(msgBack)
			TweenMax.to(msgBack, .4, {alpha:1, y:Config.HEIGHT - 110})
			TweenMax.to(msgBack, .4, {delay:7, y:Config.HEIGHT - 100, alpha:0, onComplete:removeMe})
		}
		
		private function removeMe():void
		{
			msgBack.visible = false;
		}
	}
}
