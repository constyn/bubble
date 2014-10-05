package specials.anim 
{
	import components.Body;
	import events.SoundEvent;
	import com.greensock.easing.Quad;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	/**
	 * @author taires
	 */
	public class ColdAttackAnim extends Animation
	{
		private var flakes:Array;
		
		public function ColdAttackAnim(start:Sprite, end:Sprite):void
		{
			super(start, end)
		}
				
		override public function animate():void
		{
			flakes = [];
			for(var i:int = 0; i < 20; i++)
			{
		        var flake:SnowFlake = new SnowFlake();  
				addChild(flake);	
				flake.visible = false;
				flakes.push(flake);	
			    flake.x = startSprite.x;
			    flake.y = startSprite.y;
				TweenMax.to(flake, .9, {delay:Math.random() * .2, ease:Quad.easeOut, 
										 x:endSprite.x + Math.random() * endSprite.width - endSprite.width/2, 
										 y:endSprite.y + Math.random() * endSprite.height - endSprite.height/2, 
									     onStart:onStartFunc, onStartParams:[flake],
										 onComplete:removeFlake, onCompleteParams:[flake]});
				TweenMax.to(endSprite, .5, {delay:.9, scaleX:.9, scaleY:.9,
										    onStart:playFreezeSound,
										    colorTransform:{tint:0x0000ff, tintAmount:.5}}) 	
				TweenMax.to(endSprite, .5, {delay:2,  scaleX:1, scaleY:1,
										    colorTransform:{tint:0x0000ff, tintAmount:.0},
										    onComplete:animEnd}) 				 
			}  			             
		}
		
		private function onStartFunc(flake:SnowFlake):void		
		{
			flake.visible = true;			
		}
		
		private function playFreezeSound():void
		{
			dispatchEvent(new SoundEvent(SoundEvent.PLAY_SOUND, {sound:"freeze"}, true));     	
		}
		
		private function removeFlake(flake:SnowFlake):void
		{
			if(flake && contains(flake))
				removeChild(flake)
				
			flakes.splice(flakes.indexOf(flake), 1)
		}

	}
}
