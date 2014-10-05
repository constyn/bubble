package utils
{		
	public class TextButton extends SimpleButton
	{
		
		public function TextButton(label:String, action:Function, params:Array = null, textColors:Array = null, textFormat:Object = null)
		{
		    super(label, action, params, null, textColors);
			btnWidth = 100;
	        btnHeight = 40;
			
			if (textFormat)
			{
				if(textFormat.size)
					fontSize = textFormat.size;
				if(textFormat.font)
					fontName = textFormat.font;
			}
			init();
		}
		
		override protected function init():void
		{
		    super.init();
		}
		
		override protected function drawBtn(fillColor:uint, lineColor:uint):void
		{
		    graphics.clear();
            this.graphics.beginFill(0xffffff, 0)
			graphics.drawRoundRect(0, 0, btnWidth, btnHeight, 6, 6);
			graphics.endFill()
			
			updateLabel();
		}
		
	}
}
