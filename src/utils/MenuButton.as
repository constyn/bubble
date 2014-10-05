package utils 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	import flash.geom.*
	import flash.filters.BlurFilter;
	import flash.events.*
	/**
	 * ...
	 * @author corasanu
	 */
	public class MenuButton extends SimpleButton
	{		
		public function MenuButton(label:String, action:Function, params:Array = null, colors:Array = null, textColors:Array = null, lineColors:Array = null)
		{
			super(label, action, params, colors, textColors, lineColors);
			btnWidth = 60;
	        btnHeight = 60;
		    
	        init();
		}
		
		override protected function init():void
		{
		    super.init();
			filters = [new BlurFilter(1, 1, 1)]		
		}
		
		override protected function updateLabel():void
		{
		    labelTextField.x = (btnWidth - labelTextField.width)/2 - btnWidth/2 
		    labelTextField.y = -labelTextField.height/ 2;		
		}	
		
		override protected function drawBtn(fillColor:uint, lineColor:uint):void
		{
		    var radius:Number = 50;
		    var color:Number = fillColor;
		    var opacity:Number = .98;
			var pMatrix:Matrix = new Matrix();
			pMatrix.createGradientBox(2*radius, 2*radius, 0, 0-radius-radius/10, 0-radius-radius/10);
			var r:int=color/65536*1.5, g:int=(color/256)%256*1.5, b:int=color%256*1.5;
			
			var darkColor:int= (r*256+g)*256+b;
			graphics.clear();
			graphics.lineStyle(3, color, .4)
			graphics.beginGradientFill(flash.display.GradientType.RADIAL, [color,color], [opacity,.5], [0x00,0xff], pMatrix);
			graphics.drawCircle(0,0, radius);
			graphics.endFill();
			
			graphics.lineStyle(0, color, 0.2)
			pMatrix.createGradientBox(2*radius/3, 2*radius/3, 0, -radius/3-(radius/3)-(radius/3)/10, -radius/3-(radius/3)-(radius/3)/10);			
			graphics.beginGradientFill(flash.display.GradientType.RADIAL, [0xffffff,0xffffff], [.3,.1], [0x00,0xff], pMatrix);
			graphics.drawCircle(-radius/3, -radius/3, radius/3);
			graphics.endFill();
			
		}			
		
		override protected function onRollOver(event:MouseEvent):void
		{
		    super.onRollOver(event)	
		}
		
		override protected function onRollOut(event:MouseEvent):void
		{
		    super.onRollOut(event)	
		}		
		
		
	}
}
