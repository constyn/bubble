package specials.anim 
{
	import config.Config;
	import events.SoundEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.display.SpreadMethod;
	import flash.display.GradientType;
	import com.greensock.easing.Quad;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	/**
	 * @author taires
	 */
	public class LaserAttackAnim extends Animation
	{		
		public function LaserAttackAnim(start:Sprite, end:Sprite):void
		{
			super(start, end)
		}
		
		override public function animate():void
		{
			var bar:Sprite = new Sprite()
		    var colors:Array = [Config.C5, 0xffffff, Config.C5]; 
            var alphas:Array = [.9, .9, .9]; 
            var ratios:Array = [0, 125, 255]; 
			var matrix:Matrix = new Matrix(); 
			matrix.createGradientBox(1000, 20, Math.PI/2, 0, -10);  
		    bar.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, 
                                           ratios, matrix, SpreadMethod.PAD); 
		    bar.graphics.drawRoundRect(0, -10, Math.abs(endSprite.x- startSprite.x) * 1.4, 20, 20, 20);
			bar.graphics.endFill();
			addChild(bar)	
			bar.scaleY = 0;
		    bar.x = startSprite.x + (startSprite.x < endSprite.x? 20:-bar.width - 20);
		    bar.y = startSprite.y;
			bar.alpha = 0;
			bar.scaleX = 0;
			
			TweenMax.to(bar, .3, {scaleY:1.5, alpha:1, scaleX:1, ease:Quad.easeIn, onStart:playLaserSound, 
								  glowFilter:{alpha:.5, blurX:6, blurY:6, color:0xffffff, strength:2, quality:3}});
			TweenMax.to(bar, .4, {delay:.7, scaleY:0, alpha:0, ease:Quad.easeOut});	
			TweenMax.to(endSprite, .5, {scaleX:.9, scaleY:.9,
									    colorTransform:{tint:0x000000, tintAmount:1}}) 	
			TweenMax.to(endSprite, .5, {delay:.7,  scaleX:1, scaleY:1,
									    colorTransform:{tint:0x000000, tintAmount:0},
									    onComplete:animEnd}) 	
		}
		
		private function playLaserSound():void
		{
			dispatchEvent(new SoundEvent(SoundEvent.PLAY_SOUND, {sound:"laser"}, true));     	
		}
	
	}
}
