package components
{
	import com.greensock.easing.Linear;
	import flash.filters.BlurFilter;
	import managers.EvolutionEngine;
	import model.PlayerVO;
	import model.EntityVO;
	import flash.geom.Point;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import model.WeaponVO;
	import model.CellVO;
	import flash.utils.Dictionary; 
	import com.greensock.TweenMax;
	import events.SoundEvent;
	import config.Config;
	import utils.Collisions;
	
	public class PlayerTest extends Body 
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
		private var playerVO:PlayerVO;
		
		private var moving:Boolean = false;
		
		public function PlayerTest(entityVO:EntityVO):void 
		{	 
		    super(entityVO);
			playerVO = PlayerVO(entityVO);
			keyDict = new Dictionary();   
			evoEngine = new EvolutionEngine();
			
		    createWeapons();
		}
	 	
		override protected function init(event:Event):void 
		{	 
		    super.init(event);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			
			//filters = [new BlurFilter(0,0,0)]
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
			if(playerVO.terminalV > Math.abs(xV) + Math.abs(yV))
		    {
	            if (keyDict[UP])
                {  
                    yV -= playerVO.acc; 
                    playerAngle = 0;
                    gotoMouse = false;
                }  
                if (keyDict[DOWN])
                {               
                    yV += playerVO.acc;  
                    playerAngle = 180;
                    gotoMouse = false;
                }            
                if(keyDict[LEFT])
                {
                    xV -= playerVO.acc;
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
                    xV += playerVO.acc;
                    if(keyDict[DOWN])
                        playerAngle = 135;
                    else if(keyDict[UP])
                        playerAngle = 45;
                    else
                        playerAngle = 90;
                        playerVO.acc; 
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
                        
                        xV += playerVO.acc * Math.cos(Radians) * Math.sqrt(2);     
                        yV += playerVO.acc * Math.sin(Radians) * Math.sqrt(2); 
                    }
                    else
                    {
                        gotoMouse = false;                                    
                        xV *= playerVO.decc;  
                        yV *= playerVO.decc;   
                    }                   
                }
            }           
            else
            {
                yV *= .9;
                xV *= .9;
            }
		}
		override public function update():void
		{
			checkKeys();           
            
			
			//if(!keyDict[UP] && !keyDict[DOWN] && !keyDict[RIGHT] && !keyDict[LEFT])
			//	TweenMax.killTweensOf(this);
			
			if(!moving)
		    {		        
		        var rot:Number = rotation + Math.random() * 90 - 45;	        
		        
	            moving = true;
	            TweenMax.to(this, 2, {delay:Math.random(), rotation:rot, 
	                                  onComplete:tweenEnd, ease:Linear.easeNone})    
		    }	
			
			/*
			else if(playerAngle != rotation)
				TweenMax.to(this, 1, {rotation:playerAngle});
				
			if(wayPoint && gotoMouse && playerAngle != rotation)
			   TweenMax.to(this, 1, {shortRotation:{rotation:playerAngle}}); 		
			*/
			
            if(!gotoMouse)
            {
                if((!keyDict[UP] && !keyDict[DOWN]) || (keyDict[UP] && keyDict[DOWN]))    
                    yV *= playerVO.decc               
                
                if((!keyDict[LEFT] && !keyDict[RIGHT]) || (keyDict[LEFT] && keyDict[RIGHT]))   
                    xV *= playerVO.decc   
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
				
			playerVO.pos = new Point(x, y);
		        
		    if(playerVO.xp >= playerVO.nextXPStep)
		    {
				playerVO.nextXPStep = playerVO.nextXPStep * 1.7;
		        playerVO.level++;
		        dispatchEvent(new SoundEvent(SoundEvent.PLAY_SOUND, {sound:"level"}, true));  		        
            }   
		            
		    if(playerVO.cellArray.length < playerVO.level * 2) 
		    {		        
				evoEngine.createCell(playerVO)		        
		        
				trace("drawMe")
		        createWeapons();
		    }	
			else
			{
				drawMe();
			}
			
		  
		}	
		
		private function tweenEnd():void
		{
			moving = false;
		}
		
		public function updateWayPoint(wayPoint:WayPoint):void 
		{	 
		    this.wayPoint = wayPoint;   
            gotoMouse = true;    
                   
		}	
						
		private function createWeapons():void
		{
		    for(var i:int = playerVO.weapons.length; i < Math.min(9, playerVO.level); i++)
	        {	            				
	            var weapon:Weapon = evoEngine.getSutableWeapon(playerVO, i)
				if(i == 0)
					weapon.weaponVO.attack = 200;
					
	            playerVO.weapons.push(weapon);
	        }
		}   		
	}	
}