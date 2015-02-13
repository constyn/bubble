package skills.anim {
	import config.Config;
	import model.CellVO;
	import components.cell.Cell;
	import com.greensock.easing.Quad;
	import events.GameEvent;
	import events.SoundEvent;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	/**
	 * @author taires
	 */
	public class DebuffAnim extends Animation
	{
		private var cell:Cell;
		
		public function DebuffAnim(start:Sprite, end:Sprite):void
		{
			super(start, end)
		}
		
		override public function animate():void
		{
			if(!cell)
			{
				var cellVO:CellVO = new CellVO();
			    cellVO.radius = 20;
		        cellVO.color = Config.C6;  
		        cell = new Cell(cellVO)   
			}  	
			addChild(cell)	
			cell.x = startSprite.x;
			cell.y = startSprite.y
			var dim:int = Math.max(startSprite.width, startSprite.height) * 1.3
			TweenMax.to(startSprite, .5, {scaleX:1.1, scaleY:1.1, ease:Quad.easeIn})    
			TweenMax.to(startSprite, .5, {delay:.6, scaleX:1, scaleY:1, ease:Quad.easeOut})  
			TweenMax.to(cell, .5, {width:dim, height:dim, ease:Quad.easeIn})    
			TweenMax.to(cell, .5, {delay:.6, width:1, height:1, alpha:0, ease:Quad.easeOut, onComplete:animEnd})           
		}
	
	}
}
