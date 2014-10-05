package specials.anim 
{
	import com.greensock.easing.Linear;
	import components.Cell;
	import config.Config;
	import model.CellVO;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	/**
	 * @author taires
	 */
	public class BasicAttackAnim extends Animation
	{
		private var cell:Cell;
		
		public function BasicAttackAnim(start:Sprite, end:Sprite):void
		{
			super(start, end)
		}
		
		override public function animate():void
		{
			if(!cell)
			{
				var cellVO:CellVO = new CellVO();
			    cellVO.radius = 10;
		        cellVO.color = Config.C6;  
		        cell = new Cell(cellVO)   
			}  	
			addChild(cell)	
			
		    cell.x = startSprite.x;
		    cell.y = startSprite.y;
	        TweenMax.to(cell, .5, {x:endSprite.x, y:endSprite.y, onComplete:animEnd})
	        
	      	TweenMax.to(endSprite, .1, {delay:.4, alpha:.5, 
	                    blurFilter:{blurX:3, blurY:3, quality:3}, 
	                    x:"4", 
		                yoyo:true, repeat:3, ease:Linear.easeNone,
		                onStart:playSound}) 
		             
		}
		
		override protected function animEnd(...params):void
		{			
			super.animEnd();
			if(cell && contains(cell))
				removeChild(cell);
		}	
	}
}
