/*
ActionScript 3 Tutorial by Dan Gries and Barbara Kaskosz

http://www.flashandmath.com/

Last modified: September 13, 2010

For explanations see the tutorial's page:
http://www.flashandmath.com/intermediate/cloudsfast/
*/


package components.background
{
	import components.World;
	import config.Config;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.display.Shape;
	
	public class MovingClouds extends Sprite 
	{
		
		public var numOctaves:int;
		public var skyColor:uint;
		public var cloudsHeight:int;
		public var cloudsWidth:int;
		public var periodX:Number;
		public var periodY:Number;
		public var scrollAmountX:int;
		public var scrollAmountY:int;
		public var maxScrollAmount:int;
		
		private var cloudsBitmapData:BitmapData;
		private var cloudsBitmap:Bitmap;		
		
		private var worldBitmapData:BitmapData;
		private var worldBitmap:Bitmap;
		
		private var cmf:ColorMatrixFilter;
		private var blueBackground:Shape;
		private var displayWidth:Number;
		private var displayHeight:Number;
		private var offsets:Array;
		private var sliceDataH:BitmapData;
		private var sliceDataV:BitmapData;
		private var sliceDataCorner:BitmapData;
		private var horizCutRect:Rectangle;
		private var vertCutRect:Rectangle;
		private var cornerCutRect:Rectangle;
		private var horizPastePoint:Point;
		private var vertPastePoint:Point;
		private var cornerPastePoint:Point;
		private var origin:Point;
		private var cloudsMask:Shape;
		
		public function MovingClouds(w:int = 300, h:int = 200, scX:int = 0, scY:int = 1, useBG:Boolean = true, col:uint = Config.C2)
	    {
			
			displayWidth = w;
			displayHeight = h;
			//using a factor of 1.5 below makes the cloud pattern larger than the display, so that the repetition
			//of the wrapped clouds during scrolling is not as apparent.
			cloudsWidth = Math.floor(1.5*displayWidth);
			cloudsHeight = Math.floor(1.5*displayHeight);
			periodX = periodY = 150;
			
			scrollAmountX = scX;
			scrollAmountY = scY;
			maxScrollAmount = 50;
			
			numOctaves = 5;
			
			skyColor = col;
				
			cloudsBitmapData = new BitmapData(cloudsWidth,cloudsHeight,false, 0xFF000000);
			cloudsBitmap = new Bitmap(cloudsBitmapData);			
			
			worldBitmapData = new BitmapData(Config.WIDTH, Config.HEIGHT, true, 0x000000);
			worldBitmap = new Bitmap(worldBitmapData);
			
				
			origin = new Point(0,0);
			
			cmf = new ColorMatrixFilter([0,0,0,0,255,
										 0,0,0,0,255,
										 0,0,0,0,255,
										 1,0,0,0,0]);
			
			
			cloudsMask = new Shape();
			cloudsMask.graphics.beginFill(0xFFFFFF);
			cloudsMask.graphics.drawRect(0,0,displayWidth,displayHeight);
			cloudsMask.graphics.endFill();
			
			if (useBG) {
				blueBackground = new Shape();
				blueBackground.graphics.beginFill(skyColor);
				blueBackground.graphics.drawRect(0,0,displayWidth,displayHeight);
				blueBackground.graphics.endFill();
				
				this.addChild(blueBackground);
			}
			this.addChild(cloudsBitmap);
			this.addChild(cloudsMask);
			this.addChild(worldBitmap);
			cloudsBitmap.mask = cloudsMask;
							
			makeClouds();
			setRectangles();
		
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(evt:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			this.addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function removedFromStage(evt:Event):void 
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			this.removeEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		public function setRectangles():void 
		{
			//clamp scroll amounts
			scrollAmountX = (scrollAmountX > maxScrollAmount) ? maxScrollAmount : ((scrollAmountX < -maxScrollAmount) ? -maxScrollAmount : scrollAmountX);
			scrollAmountY = (scrollAmountY > maxScrollAmount) ? maxScrollAmount : ((scrollAmountY < -maxScrollAmount) ? -maxScrollAmount : scrollAmountY);
			
			if (scrollAmountX != 0) {
				sliceDataV = new BitmapData(Math.abs(scrollAmountX), cloudsHeight - Math.abs(scrollAmountY), true);
			}
			if (scrollAmountY != 0) {
				sliceDataH = new BitmapData(cloudsWidth, Math.abs(scrollAmountY), true);
			}
			if ((scrollAmountX != 0)&&(scrollAmountY != 0)) {
				sliceDataCorner = new BitmapData(Math.abs(scrollAmountX), Math.abs(scrollAmountY), true);
			}
			horizCutRect = new Rectangle(0, cloudsHeight - scrollAmountY, cloudsWidth - Math.abs(scrollAmountX), Math.abs(scrollAmountY));
			vertCutRect = new Rectangle(cloudsWidth - scrollAmountX, 0, Math.abs(scrollAmountX), cloudsHeight - Math.abs(scrollAmountY));
			cornerCutRect = new Rectangle(cloudsWidth - scrollAmountX, cloudsHeight - scrollAmountY,Math.abs(scrollAmountX), Math.abs(scrollAmountY));
			
			horizPastePoint = new Point(scrollAmountX, 0);
			vertPastePoint = new Point(0, scrollAmountY);
			cornerPastePoint = new Point(0, 0);
			
			if (scrollAmountX < 0) {
				cornerCutRect.x = vertCutRect.x = 0;
				cornerPastePoint.x = vertPastePoint.x = cloudsWidth + scrollAmountX;
				horizCutRect.x = -scrollAmountX;
				horizPastePoint.x = 0;
			}
			if (scrollAmountY < 0) {
				cornerCutRect.y = horizCutRect.y = 0;
				cornerPastePoint.y = horizPastePoint.y = cloudsHeight + scrollAmountY;
				vertCutRect.y = -scrollAmountY;
				vertPastePoint.y = 0;
			}
			
		}
					
		private function makeClouds():void 
		{
			//create offsets array:
			offsets = []; 
			numOctaves = 1;
			for(var o:int=0;o<numOctaves;o++){
				offsets[o] = new Point(0,0);
			}
			//cloudsBitmapData.perlinNoise(164,279,numOctaves,44741,true,true,9,false,offsets);
			//cloudsBitmapData.perlinNoise(259,177,numOctaves,29684,true,true,9,false,offsets);
			//cloudsBitmapData.perlinNoise(127,270,numOctaves,79788,true,true,14,true,offsets);
			//cloudsBitmapData.perlinNoise(234,105,numOctaves,37151,true,true,14,false,offsets);
			cloudsBitmapData.perlinNoise(300,300,numOctaves,32430,true,true,15,false,offsets);
			//cloudsBitmapData.perlinNoise(periodX,periodY,numOctaves,seed,true,true,1,true,offsets);
			//cloudsBitmapData.applyFilter(cloudsBitmapData, cloudsBitmapData.rect, new Point(), cmf);
		/*	
var bgColor:Bitmap = new Bitmap(new BitmapData(500, 200, false, 0xFF000000));
addChild(bgColor);
var bitmapData:BitmapData = new BitmapData(500, 200, true);
var bitmap:Bitmap = new Bitmap(bitmapData);
addChild(bitmap);
var offsets:Array = []; var speeds:Array = [];
var numOctaves = 1;
for(var o=0;o<numOctaves;o++){
	offsets[o] = new Point(0,0);
}
speeds[0] = new Point(1.1,0.6); 
addEventListener(Event.ENTER_FRAME, animate);
function animate(e:Event):void {
	for(var o=0;o<numOctaves;o++){
		offsets[o].x += speeds[o].x;
		offsets[o].y += speeds[o].y;
	}
	bitmapData.perlinNoise(234,105,numOctaves,37151,false,true,14,false,offsets);
}*/
		}
		
		private function onEnter(evt:Event):void 
		{
			cloudsBitmapData.lock();
			
			//copy to buffers the part that will be cut off
			if (scrollAmountX != 0) {
				sliceDataV.copyPixels(cloudsBitmapData, vertCutRect, origin);
			}
			if (scrollAmountY != 0) {
				sliceDataH.copyPixels(cloudsBitmapData, horizCutRect, origin);
			}
			if ((scrollAmountX != 0)&&(scrollAmountY != 0)) {
				sliceDataCorner.copyPixels(cloudsBitmapData, cornerCutRect, origin);
			}
			
			//scroll
			cloudsBitmapData.scroll(scrollAmountX, scrollAmountY);
			
			//draw the buffers on the opposite sides
			if (scrollAmountX != 0) {
				cloudsBitmapData.copyPixels(sliceDataV, sliceDataV.rect, vertPastePoint);
			}
			if (scrollAmountY != 0) {
				cloudsBitmapData.copyPixels(sliceDataH, sliceDataH.rect, horizPastePoint);
			}
			if ((scrollAmountX != 0)&&(scrollAmountY != 0)) {
				cloudsBitmapData.copyPixels(sliceDataCorner, sliceDataCorner.rect, cornerPastePoint);
			}
			
			cloudsBitmapData.unlock();
		}


	}
	
}
