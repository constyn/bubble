package 
{

	import flash.geom.Rectangle;
	import managers.SoundManager;
	import FGL.GameTracker.GameTracker;
	import flash.display.StageScaleMode;
	import config.Config;
	import flash.display.Sprite;
	import flash.display.LoaderInfo;
	import events.*;
	import assets.Assets;	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.utils.Dictionary; 
	import managers.ViewManager;
	import model.GameModel;
	import utils.*;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
	import flash.display.StageAlign;
	import view.BadgeView;
	import view.Constants;
	import view.ControlsView;
	import view.CreditsView;
	import view.LevelSelectView;
	import view.LostView;
	import view.StartView;	

	//[SWF(width = '640', height = '480', backgroundColor = '#ffffff', frameRate = '60')]
	//[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		private var _model:GameModel;
		private var game:Game;
		private var gameMask:Sprite;
		private var tracker:GameTracker;
		private var sounds:Sounds;
		private var viewManager:ViewManager;
		private var viewMask:Sprite;

		public function Main():void 
		{	
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(event:Event):void 
		{		
			tracker = new GameTracker();		
			
			removeEventListener(Event.ADDED_TO_STAGE, init);			
			stage.scaleMode = StageScaleMode.EXACT_FIT;			   
			stage.align = StageAlign.TOP_LEFT;	
		    var sArray:Array = ["www.flashgamelicense.com", "dl.dropboxusercontent.com"];
            var sLock:SiteLock;
             
            sLock = new SiteLock(stage, true, sArray);
            if(sLock.allowedSite)
            {  	
				_model = new GameModel();
				game = new Game(_model); 				
				sounds = new Sounds(_model);
				
				this.addEventListener(SoundEvent.PLAY_SOUND, sounds.playSound);
			    this.addEventListener(SoundEvent.STOP_SOUND, sounds.stopSound);
				this.addEventListener(GameEvent.TRACK, trackGame);	
				
				tracker.beginGame(_model.points);
				
				viewManager = new ViewManager();
				addChild(viewManager);
				
				Config.WIDTH = stage.stageWidth
				Config.HEIGHT = stage.stageHeight
				
				/*viewMask = new Sprite();
				viewMask.graphics.beginFill(0xffffff, 1)
				viewMask.graphics.drawRect(0, 0, Config.WIDTH, Config.HEIGHT)
				viewMask.graphics.endFill();
				addChild(viewMask)*/
				
				//game.mask = viewMask;
				
				var startView:StartView = new StartView(_model)
				viewManager.setView(Constants.STARTUP_VIEW, startView);	
				//startView.addEventListener(GameEvent.START_GAME, game.startGame)
				//startView.addEventListener(GameEvent.CONTINUE_GAME, game.continueGame)
				viewManager.changeView(Constants.STARTUP_VIEW)
				
				viewManager.setView(Constants.GAME_VIEW, game);		
				
				this.addEventListener(ViewEvent.CHANGE_VIEW, viewManager.changeView);
			}				
		}
		
		private function trackGame(e:GameEvent):void
		{
			//trace(e.dataObj.statName)
			if(e.dataObj.statName == "level")
			{
				tracker.beginLevel(_model.currentLevel)
			}
			else if(e.dataObj.statName == "kill")
			{
				tracker.alert("dead", _model.points)
			}
			else if(e.dataObj.statName == "end")
			{
				tracker.endGame()
			}
			else
			{
				tracker.customMsg(e.dataObj.statName, "", _model.points)
			}
			
		}
	}	
}