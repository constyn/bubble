package components.cell
{
	import config.Config;
	import com.greensock.TweenMax;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.display.PixelSnapping;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.ColorTransform;
	import flash.display.Sprite;
	import flash.events.Event;
	import model.*;
	
	public class Body extends Sprite 
	{                  
		protected var entityVO:EntityVO	
		protected var cells:Array;
		protected var defaultColor:ColorTransform;
		protected var newColor:ColorTransform;
		
		protected var bgBitmap:Bitmap;
		protected var bgBmpd:BitmapData;	
		
		protected var _bodyRot:Number;
		
		public function Body(entity:EntityVO):void 
		{	       
		    entityVO = entity;   
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	 	
		protected function init(event:Event):void 
		{	
		    removeEventListener(Event.ADDED_TO_STAGE, init);	
			drawMe();			
		}
		
		public function update():void
		{
		    
		    
		}		
			
		protected function drawMe():void 
		{	
			var backSprite:Sprite = new Sprite();
            var cellArray:Array = entityVO.cellArray;
            cells = [];
            for each(var cellVO:CellVO in cellArray)
            {
				backSprite.addChild(createCell(cellVO))
            }
			bgBmpd = new BitmapData(Math.max(1,backSprite.width), Math.max(1, backSprite.height), true, 0x000000) ;
			
			if(!bgBitmap)
            	bgBitmap = new Bitmap(bgBmpd, PixelSnapping.AUTO, true);    
			else
				bgBitmap.bitmapData = bgBmpd;				        
			
			var rect:Rectangle = backSprite.getBounds(backSprite.parent);
			var pMatrix:Matrix = new Matrix();
		    pMatrix.translate(backSprite.width / 2, -rect.y);
            bgBmpd.draw(backSprite, pMatrix, null, null, null, true)
            addChild(bgBitmap); 			
			bgBitmap.x = -bgBitmap.width/2;
			bgBitmap.y = -bgBitmap.height / 2;
			bgBitmap.smoothing = true;
		}   
		
		protected function createCell(cellVO:CellVO):Cell
		{		    
		    var cell:Cell = new Cell(cellVO);
		    cell.x = cellVO.relativeX;
		    cell.y = cellVO.relativeY;
		    //addChild(cell);
		    cells.push(cell);
		    
		    return cell;
		}
		
		public function tintBody(color:uint):void
		{
			newColor = transform.colorTransform;
			newColor.color = color;			
			transform.colorTransform = newColor;		
		}
		
		public function unTint():void
		{
			transform.colorTransform = defaultColor;
		}
		
		public function onScreen():Boolean
		{
			var isOnScreen:Boolean = true;
			if(x + width < 0 || x + width > Config.WIDTH || 
			   y + height < 0 || y + height > Config.HEIGHT)
				isOnScreen = false;
				
			return isOnScreen
		}	
		
		public function playDead(target:Sprite):void
		{
			
		}
	}	
}
