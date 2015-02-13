package components
{
	import components.cell.Body;
	import components.cell.Cell;
	import flash.events.Event;
	import model.*;
	import com.greensock.TweenMax;	
	import com.greensock.easing.Linear;
	import events.GameEvent; 
	import config.Config;	
	
	public class Enemy extends Body 
	{   			
		
		private var moving:Boolean;
		private var _enemyVO:EnemyVO; 
		
		override protected function init(event:Event):void
		{
			super.init(event);
			TweenMax.from(this, 1, {alpha:0})
		}
		
		public function Enemy(entity:EntityVO):void 
		{	     
		    super(entity);
			enemyVO = EnemyVO(entity);
		}
		
		public function set enemyVO(value:EnemyVO):void 
		{	     
		    _enemyVO = value;  
		    createWeapons(); 
		}
        
        override public function update():void
		{	 
		    if(!moving)
		    {		        
		        var newXPos:Number = (Math.random() > .5? 1:-1) * Math.random()// * level * 2;		       
		        var newYPos:Number = (Math.random() > .5? 1:-1) * Math.random()// * level * 2;	
		        var rot:Number = rotation + Math.random() * 90 - 45;	        
		        
	            moving = true;
	            TweenMax.to(this, 2, {delay:Math.random(), rotation:rot, 
	                                  onUpdate:updatePosition, onUpdateParams:[newXPos, newYPos],
	                                  onComplete:tweeEnd, ease:Linear.easeNone})    
		    }
		    
		    if(x < -Config.WIDTH || x > 2*Config.WIDTH || y < -Config.HEIGHT || y > 2*Config.HEIGHT)
		        dispatchEvent(new GameEvent(GameEvent.DISPAWN, {obj:this}, true))
		}	
		
		protected function updatePosition(newX:Number, newY:Number):void
		{
		    x += newX;
		    y += newY;
		}
		
		protected function tweeEnd():void
		{		     
		    moving = false;
		}
		
		override protected function createCell(cellVO:CellVO):Cell
		{		    
		    var cell:Cell = new Cell(cellVO);
		    cell.x = cellVO.relativeX;
		    cell.y = cellVO.relativeY;
		    
		    return cell;
		}

	    public function get enemyVO():EnemyVO
		{
		    return _enemyVO;
		}
		
		private function createWeapons():void
		{
		    if(_enemyVO.weapons.length == 0)
		    {
		        for(var i:int = 0; i < 3; i++)
		        {
		            var weaponVO:WeaponVO = new WeaponVO();
		            weaponVO.attack = int(Math.random()*_enemyVO.level * 3) + 10;
		            var weapon:Weapon = new Weapon(weaponVO)
		            _enemyVO.weapons.push(weapon);
		            
		            //if(i != 0)
		            //    weaponVO.skill = Weapon.SPECIALS[(int(Math.random()*Weapon.SPECIALS.length))]
		        }
		    }
		} 	
		
		public function destroy():void
		{
		    
		}
		
		public function set dead(value:Boolean):void
		{
		    _enemyVO.dead = value;
		}
		
		public function get dead():Boolean
		{
		    return _enemyVO.dead;
		}
		
	}	
}
