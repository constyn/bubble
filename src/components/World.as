package components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.*;
	import model.*;
    import config.Config;
    import events.GameEvent;
    import flash.geom.Point;
	
	public class World extends Sprite 
	{	
		public var worldObjects:Array;
		private var _model:GameModel;
		private var enemyVOs:Array;
		private var nutriVOs:Array;
		public var wayPoint:WayPoint;
		
		public function World(model:GameModel):void 
		{	
		    _model = model;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{    
		    removeEventListener(Event.ADDED_TO_STAGE, init);
		    
		    worldObjects = [];
		    enemyVOs = []; 
		    nutriVOs = [];
		    
		    wayPoint = new WayPoint();		    
		    worldObjects.push(wayPoint)
			   
		    addEventListener(GameEvent.DISPAWN, removeObject);
		}
		
		public function updateWayPoint(point:Point):void
		{
		    wayPoint.x = point.x;
		    wayPoint.y = point.y;
		    addChild(wayPoint);
		}
		
		private function createEnemies():void
		{
		    var k:int;
		    
		    for(k = 0; k < _model.enemies.length; k++)
            {
                if(enemyVOs.indexOf(_model.enemies[k]) == -1)
                {
                    var enemyVO:EnemyVO = _model.enemies[k];
                    var enemy:Enemy = new Enemy(enemyVO)
                    enemy.enemyVO = enemyVO;
                    var enemySpawnRadius:Number = Config.WIDTH / 2 +  Math.random() * Config.WIDTH * 2;      
                    var angle:Number = Math.random() * 360;
                    enemy.x = Math.sin(angle) * enemySpawnRadius + Config.WIDTH / 2;
                    enemy.y = Math.cos(angle) * enemySpawnRadius + Config.HEIGHT / 2;	                
                    addChild(enemy)
                    worldObjects.push(enemy);
                    enemyVOs.push(enemyVO);
                }
            }     
		}
		
		private function createNutrients():void
		{
		    var k:int;
		    
		    for(k = 0; k < _model.nutrients.length; k++)
            {
                if(nutriVOs.indexOf(_model.nutrients[k]) == -1)
                {
                    var nurtiVO:NutrientVO = _model.nutrients[k];
                    var nutri:Nutrient = new Nutrient(nurtiVO)
                    nutri.x = Math.random() * Config.WIDTH * 3 - Config.WIDTH;
                    nutri.y = Math.random() * Config.HEIGHT * 3 - Config.HEIGHT; 
                    addChild(nutri)
                    worldObjects.push(nutri);
                    nutriVOs.push(nurtiVO);
                }
            }  
		}
		
		public function update():void
		{		    		    
		    createEnemies();
		    createNutrients();
		    
		    if(worldObjects)
		        for (var k:int = 0; k < worldObjects.length; k++)
				{
		            worldObjects[k].update();   
				}
		}
		
		public function updatePos(valX:Number, valY:Number):void
		{
		    var k:int;
			var l:int;
			  
			if(worldObjects)
			{
		        for(k = 0; k < worldObjects.length; k++)
		        {
		            worldObjects[k].x += (valX);
		            worldObjects[k].y += (valY);
		        }                    
            }
		}	
		
		private function removeObject(event:GameEvent):void
		{
		    var worldObj:Sprite = event.dataObj.obj
		    
		    if(worldObj && contains(worldObj))
		        removeChild(worldObj)
		   
		    if(worldObj is Enemy)
		    {
				Enemy(worldObj).destroy();
				worldObjects.splice(worldObjects.indexOf(worldObj), 1);                 
				enemyVOs.splice(enemyVOs.indexOf(Enemy(worldObj).enemyVO), 1);
				_model.enemies.splice(_model.enemies.indexOf(Enemy(worldObj).enemyVO), 1);
		    }
		    
		    if(worldObj is Nutrient)
		    {
                worldObjects.splice(worldObjects.indexOf(worldObj), 1);                 
                nutriVOs.splice(nutriVOs.indexOf(Nutrient(worldObj).nutriVO), 1);
                _model.nutrients.splice(_model.nutrients.indexOf(Nutrient(worldObj).nutriVO), 1);
		    }
		    
		}
	}	
}
