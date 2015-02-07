package specials.anim 
{
	import config.Config;
	import events.SoundEvent;
	import com.greensock.easing.Quad;
	import components.cell.Cell;
	import model.CellVO;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	/**
	 * @author taires
	 */
	public class PowerAttackAnim extends Animation
	{
		private var cell:Cell;
		
		public function PowerAttackAnim(start:Sprite, end:Sprite):void
		{
			super(start, end)
		}
				
		override public function animate():void
		{
			if(!cell)
			{
				var cellVO:CellVO = new CellVO();
			    cellVO.radius = 20;
		        cellVO.color = Config.C5;  
		        cell = new Cell(cellVO)   
			}  	
			addChild(cell)	
			
		    cell.x = startSprite.x;
		    cell.y = startSprite.y;
	        TweenMax.to(cell, .5, {x:endSprite.x, y:endSprite.y})
	        TweenMax.to(cell, .5, {delay:.5, x:endSprite.x, y:endSprite.y, onStart:playExplodeSound,
								   scaleX:3, scaleY:3, alpha:0, onComplete:animEnd})
			
	      	TweenMax.to(endSprite, .1, {delay:.4, alpha:.5, 
	                    blurFilter:{blurX:3, blurY:3, quality:3}, 
	                    x:"4", 
		                yoyo:true, repeat:3, ease:Quad.easeIn,
		                onStart:playSound}) 
		             
		}
		
		private function playExplodeSound():void
		{
			dispatchEvent(new SoundEvent(SoundEvent.PLAY_SOUND, {sound:"explosion"}, true));     	
		}
		
		override protected function animEnd(...params):void
		{			
			super.animEnd();
			if(cell && contains(cell))
				removeChild(cell);
		}	

	}
}
