package components.background
{
	import components.cell.Cell;
	import components.World;
	import flash.utils.getTimer;
	import model.GameModel;
	import model.CellVO;
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.Graphics;
	import mx.utils.NameUtil;
	import flash.display.Sprite;
	import flash.events.Event;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import config.Config;
    import flash.filters.BlurFilter;
    import flash.geom.*
	
	public class Background extends Sprite 
	{
		public var walls:Sprite;
				
		private var backSprite:Sprite;
		
		private var clouds:MovingClouds;
		private var cells:Array = [];
		private var waves:Array = [];
		private var _model:GameModel;
		private var lastWaveTime:Number = 0;
		private var lastUserPos:Point = new Point(0, 0);
		
		public function Background(model:GameModel):void 
		{	
			_model = model;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
		    removeEventListener(Event.ADDED_TO_STAGE, init);			
			clouds = new MovingClouds(Config.WIDTH, Config.HEIGHT);
			addChild(clouds)
			
			createBack();
		}
		
		private function createBack():void 
		{	
		    backSprite = new Sprite();		   
			
		    for(var k:int = 0; k < 7; k++)
            {       
				var angle:Number = Math.random() * 360;
				var totalTadius:int = Config.WIDTH / 2 + 200;
				var cellVO:CellVO = new CellVO();
				cellVO.relativeX = Config.WIDTH / 1 + Math.sin(angle) * totalTadius;
				cellVO.relativeY = Config.HEIGHT / 1 + Math.cos(angle) * totalTadius;			
				cellVO.radius = Math.random() * 3 + .1;
				cellVO.lineThickness = .1;
				cellVO.color = 0xffffff;
				var cell:Cell = new Cell(cellVO);
				cell.x = Config.WIDTH / 2;
				cell.y = Config.HEIGHT / 2;		    
				cells.push(cell);  
				cell.alpha = 0; 
				TweenMax.to(cell, 0, {delay:Math.random() * 20, alpha:.5, onComplete:reposCell, onCompleteParams:[cell]})
				backSprite.addChild(cell)             
            }
          	
			addChild(backSprite);
		}	
		
		public function update():void
		{					
			if(cells)
			{
		        for(var k:int = 0; k < cells.length; k++)
                {
					var cell:Cell = cells[k];
					var cy:Number = cell.cellVO.relativeY - y; 
                    var cx:Number = cell.cellVO.relativeX - x;
                    var Radians:Number = Math.atan2(cy,cx);
                    
                    var offseX:Number = 1 * Math.cos(Radians) * Math.sqrt(2);     
                    var offseY:Number = 1 * Math.sin(Radians) * Math.sqrt(2); 
						
                     cell.x += offseX * cell.scaleX;
                     cell.y += offseY * cell.scaleY;   
					 cell.scaleX += 0.05;
					 cell.scaleY += 0.05;				 
					 cell.filters = [new BlurFilter(Math.abs(5 - cell.scaleX), Math.abs(5 - cell.scaleX), 3)]
					 
					 if(cell.x > Config.WIDTH * 2 || cell.x < -Config.WIDTH ||
					 	cell.y > Config.HEIGHT * 2 || cell.y < -Config.HEIGHT)
					 	reposCell(cell);
                }   
            }
		}
		
		private function reposCell(cell:Cell):void
		{			
			cell.x = Config.WIDTH / 2;
			cell.y = Config.HEIGHT / 2;		 
			var angle:Number = Math.random() * 360;
			var totalTadius:int = Config.WIDTH / 2 + 200;
			cell.cellVO.relativeX = Config.WIDTH / 2 + Math.sin(angle) * totalTadius;
			cell.cellVO.relativeY = Config.HEIGHT / 2 + Math.cos(angle) * totalTadius;	
			cell.scaleX = cell.scaleY = 0;
		}
		
		public function updatePos(valX:Number, valY:Number):void
		{
			clouds.scrollAmountX = valX
		    clouds.scrollAmountY = valY
			clouds.setRectangles()
			  
			if(cells)
			{
		        for(var k:int = 0; k < cells.length; k++)
                {
					var cell:Cell = cells[k];
                    cell.x += Math.round(valX) * cell.scaleX / 4;
                    cell.y += Math.round(valY) * cell.scaleY / 4;       
                } 
            }
			
			if(waves)
			{
		        for(k = 0; k < waves.length; k++)
                {
					var wave:Sprite = waves[k];
                    wave.x += Math.round(valX);
                    wave.y += Math.round(valY);       
                } 
            }
		}		
	}	
}
