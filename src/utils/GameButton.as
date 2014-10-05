package utils 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author corasanu
	 */
	public class GameButton extends SimpleButton
	{
		public function GameButton(label:String, action:Function, params:Array = null, colors:Array = null, textColors:Array = null, lineColors:Array = null)
		{
		    super(label, action, params, colors, textColors, lineColors);
			btnWidth = 70;
	        btnHeight = 30;
	        init();
		}
		
		override protected function init():void
		{
		    super.init();
		}
	}
}
