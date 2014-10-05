package managers
{
	import components.Radar;
	import components.Body;
	import events.MessageEvent;
	import flash.geom.Point;
	import config.Config;
	import components.Enemy;
	import com.greensock.TweenMax;
	import events.GameEvent;
	import events.SoundEvent;
	import utils.Collisions;
	import components.Nutrient;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import components.MenuBar;
	import components.Background;
	import components.World;
	import components.Player;
	import model.GameModel;
	
	public class GameManager extends EventDispatcher
	{			    
		private var _model:GameModel
		private var background:Background;
		private var player:Player;
		private var world:World;
		private var game:Game;
		private var evoEngine:EvolutionEngine;
		private var menuBar:MenuBar;
		private var radar:Radar;
		private var playerLastX:Number;
		private var playerLastY:Number;	
		private var fightSimulator:FightSimulator;
		
		public function GameManager()
		{						
		}	
		
		public function setup(model:GameModel, game:Game, player:Player, world:World, background:Background, evoEngine:EvolutionEngine, menuBar:MenuBar, radar:Radar):void 
		{	
			this._model = model;
			this.player = player;
			this.background = background;	
			this.world = world;
			this.game = game;
			this.evoEngine = evoEngine;	
			this.menuBar = menuBar;
			this.radar = radar;
			fightSimulator = new FightSimulator();
			background.addEventListener(MouseEvent.CLICK, updateWayPoint)
		}		
		
		public function update():void
		{   
		    playerLastX = player.x;
		    playerLastY = player.y;
		    player.update();	
		    world.update();
			
		    evoEngine.update();
			menuBar.update();
			background.update();
		    radar.update();
			
		    for each(var obj:Sprite in world.worldObjects)   
		    {
		        if(obj is Nutrient)
	            {	
                    var nutri:Nutrient = Nutrient(obj)
                    if(Collisions.checkCollision(player, nutri))
                    {
                        //_model.player.xp += nutri.nutriVO.energy * int(Math.random() * _model.player.level + 10);
						_model.player.currentHealth = Math.min(_model.player.currentHealth + nutri.nutriVO.energy * int(Math.random() * _model.player.level + 1), _model.player.totalHealth);
                        dispatchEvent(new SoundEvent(SoundEvent.PLAY_SOUND, {sound:"pickUp"}, true));                         
                        
                        TweenMax.to(nutri, .2, {alpha:.2, y:"-5", tint:0xFFFFFF, onComplete:removeMe, onCompleteParams:[nutri]})
                       
                        world.dispatchEvent(new GameEvent(GameEvent.DISPAWN, {obj:nutri}, true)) 
						world.dispatchEvent(new MessageEvent(MessageEvent.MESSAGE, "gotcha", true)) 
                    }                                       
                
                }	
                
                if(obj is Enemy)
	            {	
                    var enemy:Enemy = Enemy(obj)
					
                    if(Collisions.checkCollision(player, enemy))
                    {
                        if(enemy.dead)           
                        {
                            TweenMax.to(enemy, .2, {alpha:.2, y:"-5", tint:0xFFFFFF, onComplete:removeMe, onCompleteParams:[enemy]})
                            world.dispatchEvent(new GameEvent(GameEvent.DISPAWN, {obj:enemy}, true)) 
                        }                          
                        else
                        {
                            TweenMax.killTweensOf(enemy);
                            TweenMax.killTweensOf(player);
                            dispatchEvent(new GameEvent(GameEvent.START_FIGHT, {enemy:enemy}, true))   
							dispatchEvent(new SoundEvent(SoundEvent.STOP_SOUND, {sound:"music"}, true));
							dispatchEvent(new SoundEvent(SoundEvent.PLAY_SOUND, {sound:"battle"}, true));			           
                      
                        }                        
                    } 
					else
					{
						for each(var obj2:Sprite in world.worldObjects)
						{	
													 
							if(obj2 is Enemy && obj != obj2)	
							{
								
								var enemy2:Enemy = Enemy(obj2)
								if((Body(obj2).onScreen() || Body(obj).onScreen()) && Collisions.checkCollision(enemy2, enemy))
                    			{
									world.dispatchEvent(new MessageEvent(MessageEvent.MESSAGE, String(world.worldObjects.length), true))
									
									if(fightSimulator.simulate(enemy.enemyVO, enemy2.enemyVO, true) == 0)
										world.dispatchEvent(new GameEvent(GameEvent.DISPAWN, {obj:enemy2}, true)) 
									else
										world.dispatchEvent(new GameEvent(GameEvent.DISPAWN, {obj:enemy}, true)) 
								}
							}
						}
					}
                }
            }	
            
			var scrollX:Number = 0;
			var scrollY:Number = 0; 
            if(player.x > Config.WIDTH * .7 || player.x < Config.WIDTH * .3)
            {
				scrollX = playerLastX - player.x;
                player.x = playerLastX;  
            }     
            
            if(player.y > Config.HEIGHT * .7 || player.y < Config.HEIGHT * .3)
            {
				scrollY = playerLastY - player.y;
                player.y = playerLastY;  
            }    
			
			if(scrollX || scrollY)
			{
				background.updatePos(scrollX, scrollY);
	            world.updatePos(scrollX, scrollY);    
			}
        }
        
        private function updateWayPoint(event:MouseEvent):void
        {
            world.updateWayPoint(new Point(event.stageX, event.stageY))
            player.updateWayPoint(world.wayPoint)
            world.wayPoint.animate();
        }
        
        private function removeMe(obj:Sprite):void
        {
            if(obj && obj.parent)
                obj.parent.removeChild(obj);
        }		
		
	}	
}
