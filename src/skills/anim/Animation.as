package skills.anim {
	import events.SoundEvent;
	import events.GameEvent;
	import flash.display.Sprite;
	/**
	 * @author taires
	 */
	public class Animation extends Sprite
	{
		protected var startSprite:Sprite;
		protected var endSprite:Sprite;
		
		public function Animation(start:Sprite, end:Sprite):void
		{
			this.startSprite = start;
			this.endSprite = end;			
			animate();
		}
		
		public function animate():void
		{
		}
		
		protected function animEnd(...params):void
		{
			dispatchEvent(new GameEvent(GameEvent.ANIM_OVER, null, true))
			startSprite.filters = [];
			endSprite.filters = [];
			startSprite = null;
			endSprite = null;
		}
		
		protected function playSound():void
		{
			dispatchEvent(new SoundEvent(SoundEvent.PLAY_SOUND, {sound:"pop"}, true));     	
		}
	}
}
