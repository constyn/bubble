package skills.anim {
	import com.greensock.easing.Quad;
	import config.Config;
	import events.GameEvent;
	import events.SoundEvent;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	/**
	 * @author taires
	 */
	public class HealAnim extends Animation
	{
		private var crosses:Array;
		
		public function HealAnim(start:Sprite, end:Sprite):void
		{
			super(start, end)
		}
		
		override public function animate():void
		{
			crosses = [];
			for(var i:int = 0; i < 20; i++)
			{
				var cross:Sprite = drawCross();
				addChild(cross);	
				cross.visible = false;
				crosses.push(cross);	
			    cross.x = startSprite.x + Math.random() * startSprite.width - startSprite.width/2;
			    cross.y = startSprite.y + Math.random() * startSprite.height - startSprite.height/2;
				TweenMax.to(cross, .6, {delay:Math.random() * .5, alpha:0, ease:Quad.easeIn, 
										y:startSprite.y - Math.random() * 100,
									    onStart:onStartFunc, onStartParams:[cross],
										onComplete:animEnd, onCompleteParams:[cross]});
			}  				             
		}
		
		private function drawCross():Sprite
		{
			var cross:Sprite = new Sprite()
			var scale:int = 4;
			cross.graphics.beginFill(Config.C5, 1);
			cross.graphics.drawRect(0, scale, scale * 3, scale)
			cross.graphics.endFill();
			cross.graphics.beginFill(Config.C5, 1);
			cross.graphics.drawRect(scale, 0, scale, scale * 3)
			cross.graphics.endFill();
			return cross
		}
		
		private function onStartFunc(cross:Sprite):void		
		{
			cross.visible = true;
			playSound();
		}
		
		override protected function animEnd(...params):void
		{
			if(params[0] && contains(params[0]))
				removeChild(params[0])
				
			crosses.splice(crosses.indexOf(params[0]), 1)
			
			if(crosses.length == 0)
				dispatchEvent(new GameEvent(GameEvent.ANIM_OVER))	
		}
				
		override protected function playSound():void
		{
			dispatchEvent(new SoundEvent(SoundEvent.PLAY_SOUND, {sound:"pop"}, true));  
		}
	
	}
}
