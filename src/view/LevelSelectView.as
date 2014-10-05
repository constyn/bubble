package view
{
	import components.Background;
	import events.ViewEvent;
	import utils.TextUtil;
	import utils.GameButton;
	import flash.events.Event;
	import flash.display.Sprite;
	import utils.LevelButton;
	import events.GameEvent;
	import model.Model;
	import config.Config;
	
	public class LevelSelectView extends View
	{
		private const LEVELS_NUM:int = 24;
	    private var levelsNum:int;
	    private var _model:Model;
	    private var buttons:Array;
		private var back:Background;   
	    
	    public function LevelSelectView(theModel:Model):void
	    {
			_model = theModel;
	    	addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void 
		{	
			removeEventListener(Event.ADDED_TO_STAGE, init);
			back = new Background();
			addChild(back);
			
			generateLevels();
		}		
	    
	    private function generateLevels():void
	    {
	        var dim:int = Config.WORLD_SCALE
	        buttons = [];
            for(var i:int = 0; i < LEVELS_NUM; i++)                
            {
                var levelBtn:LevelButton = new LevelButton(String(i + 1), selectLevel, [i + 1]);
		        addChild(levelBtn);			
		        levelBtn.x = i%6 * (levelBtn.width + dim * 10) + 80;
		        levelBtn.y = int(i/6) * (levelBtn.height + dim * 10) + 80;
		        buttons.push(levelBtn);
            }
	    }
	    
	    public function setLevels(value:int):void
	    {
	        levelsNum = value; 
	        generateLevels()   
	    }
	    
	    private function selectLevel(level:int):void
	    {
			dispatchEvent(new ViewEvent(ViewEvent.CHANGE_VIEW, {view:Constants.GAME_VIEW}, true))
	        dispatchEvent(new GameEvent(GameEvent.START_GAME, { value:level }))			
			visible = false;
	    }
	    
	    public function update():void
	    {
	        for(var i:int = 0; i < buttons.length; i++)                
            {
				var btn:LevelButton = buttons[i];
                if(_model.currentLevelUnlocked <= i)
                    btn.disable()
                else
                	btn.enable()
				
				if(_model.levelInfo[i])
				{
					var yesText:String = TextUtil.setHTMLColor("yes", "00CCFF") 
					var noText:String = TextUtil.setHTMLColor("no", "FF00CC") 
					var tipText:String = "Level " + String(i + 1)+ 
										 "\nAll coins: " + (_model.levelInfo[i][Levels.ALL_COINS]?yesText:noText)+
										 "\nAll fuel: " + (_model.levelInfo[i][Levels.ALL_FUEL]?yesText:noText)+
										 "\nAll hearts: " + (_model.levelInfo[i][Levels.ALL_HEARTS]?yesText:noText)+
										 "\nEfficient: " + (_model.levelInfo[i][Levels.EFFICIENT]?yesText:noText)+
										 "\nClean Finish: " + (_model.levelInfo[i][Levels.DIED]?noText:yesText) 
								
					btn.setToolTip(tipText)
				}
				else
				{
					btn.setToolTip("Level " + String(i + 1))					
				}
            }    
	    }
	}
}
	
		
