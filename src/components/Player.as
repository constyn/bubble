package components
{
	import components.cell.Body;
	import components.cell.Cell;
	import events.SoundEvent;
	import flash.events.Event;	
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import managers.EvolutionEngine;
	import model.*;
	import com.greensock.TweenMax;	
	import com.greensock.easing.Linear;
	import events.GameEvent; 
	import config.Config;	
	import utils.Collisions;
	
	public class Player extends Body 
	{   			
		private const LEFT:Number = 37;
        private const UP:Number = 38;
        private const RIGHT:Number = 39;
        private const DOWN:Number = 40;
        //private const SPACE:Number = 32;
        private const W:Number = 87;
        private const A:Number = 65;
        private const S:Number = 83;
        private const D:Number = 68;
        
        private var wayPoint:WayPoint;   
        private var gotoMouse:Boolean;        
        
        private var xV:Number = 0;
		private var yV:Number = 0;	
        
        private var keyDict:Dictionary; 
            
		private var playerAngle:int;
		private var evoEngine:EvolutionEngine;
		
		private var moving:Boolean = false;
		private var _vo:PlayerVO; 
		
		override protected function init(event:Event):void
		{
			super.init(event);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			//TweenMax.from(this, 1, {alpha:0})
		}
		
		public function Player(entity:EntityVO):void 
		{	     
		    super(entity);
			_vo = PlayerVO(entity);
			evoEngine = new EvolutionEngine();			
			keyDict = new Dictionary(); 
			
			createWeapons();
		}
		
		private function keyDown(event:KeyboardEvent):void
		{	
		    if(event.keyCode == W)
	            keyDict[UP] = true;
	        else if(event.keyCode == S)
	            keyDict[DOWN] = true;
	        else if(event.keyCode == A)
	            keyDict[LEFT] = true;
	        else if(event.keyCode == D)
	            keyDict[RIGHT] = true;
		    else    
                keyDict[event.keyCode] = true;
		}
		
		private function keyUp(event:KeyboardEvent):void
		{
		    if(event.keyCode == W)
	            keyDict[UP] = false;
	        else if(event.keyCode == S)
	            keyDict[DOWN] = false;
	        else if(event.keyCode == A)
	            keyDict[LEFT] = false;
	        else if(event.keyCode == D)
	            keyDict[RIGHT] = false;
		    else    
		        keyDict[event.keyCode] = false;			    
		}
		
		private function checkKeys():void
		{
			if(_vo.terminalV > Math.abs(xV) + Math.abs(yV))
		    {
	            if (keyDict[UP])
                {  
                    yV -= _vo.acc; 
                    playerAngle = 0;
                    gotoMouse = false;
                }  
                if (keyDict[DOWN])
                {               
                    yV += _vo.acc;  
                    playerAngle = 180;
                    gotoMouse = false;
                }            
                if(keyDict[LEFT])
                {
                    xV -= _vo.acc;
                    if(keyDict[DOWN])
                        playerAngle = -135;
                    else if(keyDict[UP])
                        playerAngle = -45;
                    else
                        playerAngle = -90;
                        
                    gotoMouse = false;
                }
                if(keyDict[RIGHT])
                {    
                    xV += _vo.acc;
                    if(keyDict[DOWN])
                        playerAngle = 135;
                    else if(keyDict[UP])
                        playerAngle = 45;
                    else
                        playerAngle = 90;
                        _vo.acc; 
                    gotoMouse = false;
                } 
				
				if(wayPoint && gotoMouse)
                {
                    if(!Collisions.checkCollision(this, wayPoint))
                    {                                   
                        var cy:Number = wayPoint.y - y; 
                        var cx:Number = wayPoint.x - x;
                        var Radians:Number = Math.atan2(cy,cx);
                        var Degrees:Number = Radians * 180 / Math.PI;
                        playerAngle = Degrees + 90;
                        
                        xV += _vo.acc * Math.cos(Radians) * Math.sqrt(2);     
                        yV += _vo.acc * Math.sin(Radians) * Math.sqrt(2); 
                    }
                    else
                    {
                        gotoMouse = false;                                    
                        xV *= _vo.decc;  
                        yV *= _vo.decc;   
                    }                   
                }
            }           
            else
            {
                yV *= .9;
                xV *= .9;
            }
		}
		
		public function set vo(value:PlayerVO):void 
		{	     
		    _vo = value;  
		    createWeapons(); 
		}
        
        override public function update():void
		{	 
		   checkKeys();           
            
			
			if(!keyDict[UP] && !keyDict[DOWN] && !keyDict[RIGHT] && !keyDict[LEFT])
				TweenMax.killTweensOf(this);
			else if(playerAngle != rotation)
				TweenMax.to(this, 1, {shortRotation:{rotation:playerAngle}});
				
			if(wayPoint && gotoMouse && playerAngle != rotation)
			   TweenMax.to(this, 1, {shortRotation:{rotation:playerAngle}}); 		
			
			
            if(!gotoMouse)
            {
                if((!keyDict[UP] && !keyDict[DOWN]) || (keyDict[UP] && keyDict[DOWN]))    
                    yV *= _vo.decc               
                
                if((!keyDict[LEFT] && !keyDict[RIGHT]) || (keyDict[LEFT] && keyDict[RIGHT]))   
                    xV *= _vo.decc   
            }
            if(Math.abs(xV) < 0.01)
				xV = 0;
			if(Math.abs(yV) < 0.01)
				yV = 0;
				
            if(x + xV - width/2 > 0 && x + xV + width/2 < Config.WIDTH)                  
	            x += xV;
	        else 
	            xV = 0;
	            
	        if(y + yV - height/2 > 0 && y + yV + height/2 < Config.HEIGHT)                  
	            y += yV;
	        else 
	            yV = 0;   
				
			_vo.pos = new Point(x, y);
		        
		    if(_vo.xp >= _vo.nextXPStep)
		    {
				_vo.level++;
				_vo.nextXPStep += Math.pow(_vo.level, 0.5) * 100;		       
		        dispatchEvent(new SoundEvent(SoundEvent.PLAY_SOUND, {sound:"level"}, true));  		        
            }   
		            
		    if(_vo.cellArray.length < _vo.level * 2) 
		    {		        
				evoEngine.createCell(_vo)		        
		        createWeapons();
		    }	
			else
			{
				drawMe();
			}
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
			
		public function updateWayPoint(wayPoint:WayPoint):void 
		{	 
		    this.wayPoint = wayPoint;   
            gotoMouse = true;    
                   
		}	

	    public function get vo():PlayerVO
		{
		    return _vo;
		}
		
		private function createWeapons():void
		{
		    for(var i:int = _vo.weapons.length; i < Math.min(9, _vo.level); i++)
	        {	            				
	            var weapon:Weapon = evoEngine.getSutableWeapon(_vo, i)
				if(i == 0)
					weapon.weaponVO.damage = 2000;
					
	            _vo.weapons.push(weapon);
	        }
		} 	
		
		public function destroy():void
		{
		    
		}
		
		public function set dead(value:Boolean):void
		{
		    _vo.dead = value;
		}
		
		public function get dead():Boolean
		{
		    return _vo.dead;
		}
		
	}	
}
