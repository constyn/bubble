package 
{
	import components.background.Background;
	import components.fight.FightScreen;
	import components.ui.MenuBar;
	import components.ui.Radar;
	import events.MessageEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import managers.EvolutionEngine;
	import managers.FightManager;
	import managers.GameManager;
	import managers.MessageManager;
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.display.Sprite;
	import flash.events.Event;
	import model.*;
	import components.*;
	import events.SoundEvent;
	import events.GameEvent;	
	import com.greensock.*;	
	import config.Config;
	import view.View;
	
	public class Game extends View 
	{
		
		private var _model:GameModel
		private var background:Background;
		
		private var player:Player;
		private var manager:GameManager;
		private var menuBar:MenuBar;
		
		private var world:World;
		private var fightScreen:FightScreen;
		private var fightManager:FightManager;
		private var msgManager:MessageManager;
		private var radar:Radar;
		private var evoEngine:EvolutionEngine;
		private var gameTimer:Timer;
		
		public function Game(model:GameModel):void 
		{	
		    _model = model;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void 
		{	 
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			background = new Background(_model);
			addChild(background);
			
			world = new World(_model);
		    addChild(world)
			
			player = new Player(_model.player);
			player.x = Config.WIDTH / 2;
			player.y = Config.HEIGHT / 2;	
			addChild(player);
			
			menuBar = new MenuBar(_model)
			addChild(menuBar)
			menuBar.y = Config.HEIGHT - menuBar.height;
			
			gameTimer = new Timer(10, 0)
			gameTimer.addEventListener(TimerEvent.TIMER, update)
			gameTimer.start();
			//addEventListener(Event.ENTER_FRAME, update);
			
			evoEngine = new EvolutionEngine()
			evoEngine.setup(_model);
			
			radar = new Radar(world, player)
			addChild(radar)
			
			manager = new GameManager();
			manager.setup(_model, this, player, world, background, evoEngine, menuBar, radar);
			
			msgManager = new MessageManager();
			addChild(msgManager);			
			
			manager.addEventListener(GameEvent.START_FIGHT, startFight);
			manager.addEventListener(SoundEvent.PLAY_SOUND, playSound);		
			addEventListener(MessageEvent.MESSAGE, showMsg);	
			msgManager.showMessage("heeeeei")	
			
			//dispatchEvent(new SoundEvent(SoundEvent.PLAY_SOUND, {sound:"music"}, true));   
		}	
		
		private function update(event:Event = null):void
		{		
		    if(_model.battleMode)
		        fightManager.update();
		    else    
		        manager.update();
		}
		
		private function playSound(event:SoundEvent):void
		{
		    dispatchEvent(new SoundEvent(SoundEvent.PLAY_SOUND, event.dataObj, true));   
		}
		
		private function showMsg(event:MessageEvent):void
		{
		    msgManager.showMessage(event.msg);
		}
		
		private function startFight(event:GameEvent):void
		{
			var bmd:BitmapData = new BitmapData(Config.WIDTH, Config.HEIGHT)
		    _model.battleMode = true;
			
		    if(!fightScreen)
		    {
		        //TweenMax.killAll();
		        bmd.draw(this)
		        fightScreen = new FightScreen(_model, bmd, event.dataObj.enemy.enemyVO)
		        addChild(fightScreen)
		        
		        fightManager = new FightManager();
			    fightManager.setup(_model, player, event.dataObj.enemy, fightScreen);			
			    fightManager.addEventListener(GameEvent.END_FIGHT, endFight);
			    fightManager.addEventListener(GameEvent.GAME_OVER, gameOver);
		    }
		    else
		    {
				bmd.draw(this)
		        fightScreen = new FightScreen(_model, bmd, event.dataObj.enemy.enemyVO)
		        addChild(fightScreen)
		        
		        fightManager.setup(_model, player, event.dataObj.enemy, fightScreen);	
		    }
			
			background.visible = false;
			world.visible = false;
			player.visible = false;			
		}
				
		private function endFight(event:GameEvent):void
		{
		    _model.battleMode = false;
		    fightScreen.visible = false;
			
			background.visible = true;
			world.visible = true;
			player.visible = true;
		}
		
		private function gameOver(str:String):void
		{	
		    TweenMax.killAll();	 
		    gameTimer.stop();
			dispatchEvent(new GameEvent(GameEvent.GAME_OVER));
			
			background.filters  = [];
			world.filters  = [];
			player.filters = [];
		}	
	}	
}
