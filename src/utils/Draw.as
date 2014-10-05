package utils 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author taires
	 */
	public class Draw 
	{
		
		public function Draw() 
		{
			
		}
		
		public static function drawRoundRect(sp:Sprite, _x:int, _y:int, _width:int, _heigth:int, _round:int, _color:uint, _alpha:Number):void 
		{			
			sp.graphics.beginFill(_color, _alpha);
			sp.graphics.drawRoundRect(_x, _y, _width, _heigth, _round, _round);		    
			sp.graphics.endFill();
			
			if (_width > 4 && _heigth > 4)
			{
				sp.graphics.beginFill(0xffffff, _alpha * .7);
				sp.graphics.drawRoundRect(_x + 2, _y + 1, _width - 4, 3, _round, _round);		    
				sp.graphics.endFill();
			}
		}
		
	}

}