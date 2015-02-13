package skills.anim {
	import com.greensock.easing.Linear;
	import com.greensock.easing.Quad;
	import config.Config;
	import events.GameEvent;
	import events.SoundEvent;
	import components.cell.Cell;
	import model.CellVO;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	/**
	 * @author taires
	 */
	public class DrainAttackAnim extends Animation
	{
		private var cells:Array;
		
		public function DrainAttackAnim(start:Sprite, end:Sprite):void
		{
			super(start, end)
		}
		
		override public function animate():void
		{
			cells = [];
			for(var i:int = 0; i < 20; i++)
			{
				var cellVO:CellVO = new CellVO();
			    cellVO.radius = Math.random() * 3 + 3;
		        cellVO.color = Config.C2;  
		        var cell:Cell = new Cell(cellVO);  
				addChild(cell);	
				cell.visible = false;
				cells.push(cell);	
			    cell.x = startSprite.x;
			    cell.y = startSprite.y;
				cell.alpha = 2;
				TweenMax.from(cell, .6, {delay:Math.random() * .5, alpha:.7, ease:Quad.easeIn, x:endSprite.x, 
										 y:endSprite.y + Math.random() * startSprite.height - startSprite.height/2, 
									     onStart:onStartFunc, onStartParams:[cell],
										 onComplete:animEnd, onCompleteParams:[cell]});
				TweenMax.to(endSprite, .6, {scaleX:.9, scaleY:.9, ease:Linear.easeNone}) 
				TweenMax.to(endSprite, .6, {delay:.6, scaleX:1, scaleY:1, ease:Linear.easeNone}) 
				TweenMax.to(startSprite, .5, {delay:.55, scaleX:1.1, scaleY:1.1, ease:Linear.easeNone}) 
				TweenMax.to(startSprite, .6, {delay:1, scaleX:1, scaleY:1, ease:Linear.easeNone, onComplete:animEnd}) 
			}  				             
		}
		
		private function onStartFunc(cell:Cell):void		
		{
			cell.visible = true;
			playSound();
		}
		
		override protected function animEnd(...params):void
		{
			if(params[0] && contains(params[0]))
				removeChild(params[0])
				
			cells.splice(cells.indexOf(params[0]), 1)
			
			if(!params[0])
				dispatchEvent(new GameEvent(GameEvent.ANIM_OVER))	
		}
				
		override protected function playSound():void
		{
			dispatchEvent(new SoundEvent(SoundEvent.PLAY_SOUND, {sound:"pop"}, true));  
		}
	
	}
}
