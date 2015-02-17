package utils 
{
	
	import flash.filters.GlowFilter;
	import flash.text.*;
	import flash.filters.BlurFilter;
	/**
	 * ...
	 * @author taires
	 */
	public class TextUtil 
	{
		public static var DEFAULT_FONT:String = "Fago";
		
		public static var color:uint;
		public static var size:int; 
		public static var italic:Boolean;
		public static var bold:Boolean; 
		public static var contour:uint; 
		public static var contourThickness:uint; 
		public static var align:String;
		public static var autoSize:String;
		public static var font:String;
		
		public static function createText(data:Object = null):Label
		{		
			color = 0xFFFFFF;
			font = DEFAULT_FONT;
			size = 13; 
			italic = false; 
			bold = false; 
			align = TextFormatAlign.LEFT; 
			autoSize = TextFieldAutoSize.LEFT;
			contour = undefined; 
			contourThickness = undefined; 
		
			if (data)
			{
				if (data.color)
					color = data.color;
				if (data.size)
					size = data.size;
				if (data.font)
					font = data.font;
				if (data.italic)
					italic = data.italic;
				if (data.bold)
					bold = data.bold;
				if (data.align)
					align = data.align;
				if (data.autoSize)
					autoSize = data.autoSize;
				if (data.contour)
					contour = data.contour;
				if (data.contourThickness)
					contourThickness = data.contourThickness;	
			}
			
		    var newText:Label = new Label()
			newText.multiline = false;
			newText.mouseEnabled = false;
			newText.selectable = false;
			newText.autoSize = autoSize;
			newText.embedFonts = true;
			newText.filters = [new BlurFilter(0,0,0)];
			
			if (contour)
			{
				newText.filters = [new GlowFilter(contour, 1, 2, 2, 20, 3)];
				if (contourThickness)
					newText.filters = [new GlowFilter(contour, 1, contourThickness, contourThickness, 20, 3)];
			}
			
			var tf:TextFormat = new TextFormat(font, size, color);
			tf.align = align;
			tf.italic = italic;
			tf.bold = bold;
			newText.defaultTextFormat = tf;		
			
			data = null;
			return newText;
		}
		
		public static function setHTMLColor(str:String, color:uint):String
		{
			return "<FONT COLOR='#" + color.toString(16) + "'>" +  str + "</FONT>"
		}
		
	}

}
