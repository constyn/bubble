package utils 
{
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author corasanu
	 */
	public class SimpleButton extends Sprite
	{
		protected const NORM:int = 0;
		protected const OVER:int = 1;
		protected const DOWN:int = 2;
		protected const DISABLED:int = 3;
		
	    protected var btnWidth:int;
	    protected var btnHeight:int;
	    
	    protected var _label:String;
	    protected var _action:Function;
	    protected var _params:Array;
		protected var labelTextField:Label;
		
		protected var fontSize:int = 13;
		protected var fontName:String = "Fago";
		
		private var mouseDown:Boolean;
		private var mouseOver:Boolean;
		
		protected var fillColors:Array = [0x111111, 0x333333, 0x222222, 0x222222]
		protected var lineColors:Array = [0x555555,  0xCCCCCC, 0xDDDDDD, 0xDDDDDD]
		protected var textColors:Array = [0xAAAAAA,  0xEEEEEE, 0xAAAAAA, 0xAAAAAA]
		
		public function SimpleButton(label:String, action:Function, params:Array = null, colors:Array = null, textColors:Array = null, lineColors:Array = null) 
		{
			_label = label;
			_action = action;
			_params = params;
			
			if(colors)
				this.fillColors = colors;
			
			if(textColors)
				this.textColors = textColors;
						
			if(lineColors)
				this.lineColors = lineColors;
		}
		
		protected function init():void
		{	
		    setListeners("addEventListener");	
			buttonMode = true;	
			
			labelTextField = TextUtil.createText();
			addChild(labelTextField);
			labelTextField.width = btnWidth;
			labelTextField.multiline = false;
			labelTextField.mouseEnabled = false;
			labelTextField.selectable = false;
			labelTextField.autoSize = TextFieldAutoSize.CENTER;
			
			var tf:TextFormat = new TextFormat(fontName, fontSize, textColors[NORM]);
			tf.align = TextFormatAlign.CENTER;
			labelTextField.defaultTextFormat = tf;	
			
			labelTextField.text = _label;	
			updateLabel();	
			
			drawBtn(fillColors[NORM], lineColors[NORM]);		
		}
		
		protected function drawBtn(fillColor:uint, lineColor:uint):void
		{
		    graphics.clear();
		    graphics.lineStyle(1, lineColor, 0.8, true)
			var fillType:String = GradientType.LINEAR;
            var alphas:Array = [1, 1];
            var ratios:Array = [0x00, 0xFF];
            var matr:Matrix = new Matrix();            
            matr.createGradientBox(btnWidth, btnHeight, Math.PI/180 * 90, 0, 0);
            var spreadMethod:String = SpreadMethod.PAD;
            this.graphics.beginGradientFill(fillType, [fillColor, fillColor + 0x111111], alphas, ratios, matr, spreadMethod);  
			graphics.drawRoundRect(0, 0, btnWidth, btnHeight, 6, 6);
			graphics.endFill()
			
			graphics.lineStyle(0,0,0)
			graphics.beginFill(0xffffff, .1);
			graphics.drawRoundRect(2, 1, btnWidth - 4, 3, 6, 6);		    
			graphics.endFill();
			
			updateLabel();
		}	
		
		protected function updateLabel():void
		{
			labelTextField.x = int((width - labelTextField.width) / 2);
		    labelTextField.y = int((height - labelTextField.height) / 2);		
		}	
		
		protected function setListeners(action:String):void
		{
		    this[action](MouseEvent.CLICK, callFunction);
		    this[action](MouseEvent.ROLL_OVER, onRollOver);
		    this[action](MouseEvent.ROLL_OUT, onRollOut);
		    this[action](MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		protected function onRollOver(event:MouseEvent):void
		{	
			mouseOver = true;
			
		    if(mouseDown) return;	
		        
		    drawBtn(fillColors[OVER], lineColors[OVER]);
		    
		    var tf:TextFormat = new TextFormat(fontName, fontSize, textColors[OVER]);
			tf.align = TextFormatAlign.CENTER;
			labelTextField.setTextFormat(tf);
		}
		
		protected function onRollOut(event:MouseEvent):void
		{
			mouseOver = false;
			
		    if(mouseDown) return;
		    
		    drawBtn(fillColors[NORM], lineColors[NORM]);
		    
		    var tf:TextFormat = new TextFormat(fontName, fontSize, textColors[NORM]);
			tf.align = TextFormatAlign.CENTER;
			labelTextField.setTextFormat(tf);
		}	
		
		protected function onMouseDown(event:MouseEvent):void
		{		    
		    mouseDown = true;
		    
		    drawBtn(fillColors[DOWN], lineColors[DOWN]);
		    
		    var tf:TextFormat = new TextFormat(fontName, fontSize, textColors[DOWN]);
			tf.align = TextFormatAlign.CENTER;
			labelTextField.setTextFormat(tf);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		    addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}	
		
		protected function onMouseUp(event:MouseEvent):void
		{		    
		    mouseDown = false;
		   	
			var tf:TextFormat;
			
			if(mouseOver)
			{
				tf = new TextFormat(fontName, fontSize, textColors[OVER]);
				drawBtn(fillColors[OVER], lineColors[OVER]);
			}
			else
			{
				tf = new TextFormat(fontName, fontSize, textColors[NORM]);
		    	drawBtn(fillColors[NORM], lineColors[NORM]);
			}		    
		    
			tf.align = TextFormatAlign.CENTER;
			labelTextField.setTextFormat(tf);
			
		    stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		    removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}		
		
		protected function callFunction(event:MouseEvent):void
		{
		    mouseDown = false;
		    
		    if(_params)
		        _action.apply(null, _params);
		    else
		        _action.apply();
		}	
		
		public function get label():String
		{
		    return _label;
		}	
		
		public function set label(value:String):void
		{
		    _label = value;
		    labelTextField.text = value;
		    updateLabel();
		}
		
		public function setSize(w:int, h:int):void
		{
		    btnWidth = w;
		    btnHeight = h;
		    
		    drawBtn(fillColors[NORM], lineColors[NORM]);
		}
		
		public function disable():void
		{
			alpha = .7
			mouseEnabled = false;
			mouseChildren = false;
			drawBtn(fillColors[DISABLED], lineColors[DISABLED]);
			var tf:TextFormat = new TextFormat(fontName, fontSize, textColors[DISABLED]);
			tf.align = TextFormatAlign.CENTER;
			labelTextField.setTextFormat(tf);
		}
		
		public function enable():void
		{
			alpha = 1
			mouseEnabled = true;
			mouseChildren = true;
			drawBtn(fillColors[NORM], lineColors[NORM]);
			var tf:TextFormat = new TextFormat(fontName, fontSize, textColors[NORM]);
			tf.align = TextFormatAlign.CENTER;
			labelTextField.defaultTextFormat = tf;	
		}
	}
}
