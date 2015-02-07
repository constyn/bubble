package components.menu
{
	import flash.events.Event;
	import config.Config;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import utils.Draw;
	import utils.TextUtil;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.display.Sprite;
	
	public class ToolTip extends Sprite 
	{		
		private var str:String;		
		private var label:TextField;
		private var toolTipBack:Sprite;	
		
		public function ToolTip(str:String):void 
		{	
		    this.str = str;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
		    removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var tf:TextFormat = new TextFormat("Verdana", 10, 0xCCCCCC); 
		    tf.align = TextFormatAlign.CENTER;
		    
		    label = TextUtil.createText();		    					
			label.x = 2;
			label.y = 2;
			
		    label.htmlText = str;
		    
		    toolTipBack = new Sprite();
			Draw.drawRoundRect(toolTipBack, 0, 0, label.width + 4, label.height + 4, 5, 0x000000, .7)
		    addChild(toolTipBack);
		    addChild(label);
			
			this.x = (50-width) / 2
			this.y = -height
			
			var point:Point = new Point(x, y)
			point = localToLocal(parent, parent.stage, point)
			if(point.x + width > Config.WIDTH)
				x -= point.x + width - Config.WIDTH;	
		}
		
		private function localToLocal(containerFrom:DisplayObject, containerTo:DisplayObject, origin:Point=null):Point
        {
            var point:Point = origin ? origin : new Point();
            point = containerFrom.localToGlobal(point);
            point = containerTo.globalToLocal(point);
            return point;
        }
		
	}
}
