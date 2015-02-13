package components.fight {
	import config.Config;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
    import flash.geom.Matrix;    
	import com.greensock.TweenMax;
	import flash.display.GradientType; 
	import flash.display.SpreadMethod;
	import events.*;
	import utils.Draw;
	
	public class FightTimeBar extends Sprite 
	{		
		private var bar:Sprite;
		private var barMask:Sprite;
		private var barBack:Sprite;
		private var ghostBack:Sprite;
		private var levels:Array = [.33, .66, 1];
		private var currentLevel:int = 0;
		
		public function FightTimeBar():void 
		{	
		   addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void 
		{	
		    var corner:int = 10;
		    var barHeight:int = 12;
		    var barSegmentWidth:int = 40;
		    var padding:int = 3;
		    
		    removeEventListener(Event.ADDED_TO_STAGE, init);
		    
		    barBack = new Sprite()
			Draw.drawRoundRect(barBack, 0, 0, barSegmentWidth*3 + padding*2, barHeight + padding*2, corner, Config.C1, 1)
            var colors:Array = [0x333333, 0x333333]; 
            var alphas:Array = [.4, .5]; 
            var ratios:Array = [0, 255];              
            var matrix:Matrix = new Matrix(); 
            matrix.createGradientBox(barSegmentWidth * 3, barHeight, Math.PI/2, padding, padding); 
            barBack.graphics.beginGradientFill(GradientType.RADIAL, colors, alphas, 
                                               ratios, matrix, SpreadMethod.PAD); 
			
		    barBack.graphics.drawRoundRect(padding, padding, barSegmentWidth, barHeight, corner, corner);
		    barBack.graphics.drawRoundRect(barSegmentWidth + padding, padding, barSegmentWidth, barHeight, corner, corner);
		    barBack.graphics.drawRoundRect(barSegmentWidth * 2 + padding, padding, barSegmentWidth, barHeight, corner, corner);
			barBack.graphics.endFill();
			addChild(barBack);
			
			ghostBack = new Sprite()
		    ghostBack.graphics.beginFill(0xFFFFFF, 1)
		    ghostBack.graphics.drawRoundRect(-(barSegmentWidth*3 + padding*2)/2, -(barHeight + padding*2)/2, 
		                                      barSegmentWidth*3 + padding*2, barHeight + padding*2, corner, corner);
			ghostBack.graphics.endFill();
			addChild(ghostBack);
			ghostBack.alpha = 0;
			ghostBack.x = (barSegmentWidth*3 + padding*2)/2;
			ghostBack.y = (barHeight + padding*2)/2
			
			barMask = new Sprite()
		    barMask.graphics.beginFill(Config.C2, 1)
		    barMask.graphics.drawRoundRect(padding, padding, barSegmentWidth, barHeight, corner, corner);
		    barMask.graphics.drawRoundRect(barSegmentWidth + padding, padding, barSegmentWidth, barHeight, corner, corner);
		    barMask.graphics.drawRoundRect(barSegmentWidth * 2 + padding, padding, barSegmentWidth, barHeight, corner, corner);
			barMask.graphics.endFill();
			addChild(barMask)
		    
		    bar = new Sprite()
		    bar.mask = barMask;
		    
		    colors = [Config.C2, 0xE300B6]; 
            alphas = [.9, .9]; 
            ratios = [0, 255];  
		    bar.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, 
                                           ratios, matrix, SpreadMethod.PAD); 
		    bar.graphics.drawRoundRect(padding, padding, barSegmentWidth*3, barHeight, corner, corner);
			bar.graphics.endFill();
			addChild(bar)	
			bar.scaleX = 0;
			
			filters = [new DropShadowFilter(3, 45, 0, .5, 4, 4)]
		}
		
		public function update(value:Number):void
		{
		    bar.scaleX = value;
		    
			
		    if(levels[currentLevel] <= value)
			{
				currentLevel++
				TweenMax.to(bar, .2, {tint:0xFDCBCB, yoyo:true, repeat:1})
		        
		        ghostBack.alpha = 1;
		        ghostBack.scaleX = 1;
		        ghostBack.scaleY = 1;		        
		        TweenMax.to(ghostBack, .4, {alpha:0, scaleX:1.1, scaleY:1.7})
		        
		        dispatchEvent(new SoundEvent(SoundEvent.PLAY_SOUND, {sound:"load"}, true));    
			}
			else if(value - levels[currentLevel-1] < 0 && currentLevel > 0)
			{
				currentLevel--;
			}
		}
		
	}
}
