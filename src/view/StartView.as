package view
{
	import events.ViewEvent;
	import model.GameModel;
	import events.GameEvent;
	import config.Config;
	import utils.SimpleButton;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import flash.events.Event;
	import utils.MenuButton;
	import flash.display.Sprite;
    import components.Background;
	
	public class StartView extends View 
	{		
		private var newGameButton:MenuButton;
		private var continueButton:MenuButton;
		private var btnContainer:Sprite;
		private var _model:GameModel;
		private var backSprite:Background;
		
		public function StartView(theModel:GameModel):void 
		{	
			_model = theModel;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
		    removeEventListener(Event.ADDED_TO_STAGE, init)		    
		    
		    createBack();	
		    
		    btnContainer = new Sprite();
		   
		    addChild(btnContainer);
		    
			newGameButton = new MenuButton("NEW\nGAME", startNewGame, null, [Config.C6, Config.C4, Config.C5], [Config.C1, Config.C5, Config.C4])
		    btnContainer.addChild(newGameButton);
		                         
			continueButton = new MenuButton("CONTINUE", continueGame, null, [Config.C6, Config.C4, Config.C5], [Config.C1, Config.C5, Config.C4])
		    btnContainer.addChild(continueButton);	
		    
		    arangeButtons();
		     
		    TweenMax.to(newGameButton, 1, {bezier:[{x:newGameButton.x - 10 + 20 * Math.random(), y:newGameButton.y - 10 + 20 * Math.random()}, 
		                                           {x:newGameButton.x - 10 + 20 * Math.random(), y:newGameButton.y - 10 + 20 * Math.random()}], 
		                                   ease:Linear.easeOut, onComplete:updateTween, onCompleteParams:[newGameButton]});
		                                   
		    TweenMax.to(continueButton, 1, {bezier:[{x:continueButton.x - 10 + 20 * Math.random(), y:continueButton.y - 10 + 20 * Math.random()}, 
		                                            {x:continueButton.x - 10 + 20 * Math.random(), y:continueButton.y - 10 + 20 * Math.random()}], 
		                                    ease:Linear.easeOut, onComplete:updateTween, onCompleteParams:[continueButton]});			   
		}
		
		private function updateTween(btn:SimpleButton):void
		{
		    TweenMax.to(btn, Math.random() * .5 + .5, {bezier:[{x:btn.x - 10 + 20 * Math.random(), y:btn.y - 10 + 20 * Math.random()}, 
		                                    {x:btn.x - 10 + 20 * Math.random(), y:btn.y - 10 + 20 * Math.random()}], 
		                ease:Linear.easeOut, onComplete:updateTween, onCompleteParams:[btn],
		                yoyo:true, repeat:1});    
		}
		
		private function arangeButtons():void
		{
		    for (var i:int; i < btnContainer.numChildren; i++)
		    {
		        var btn:MenuButton = MenuButton(btnContainer.getChildAt(i))
		        btn.x = btn.width/2;
		        btn.y = (btn.height  + 10)* i + btn.height/2	        
		    }
		    
		    btnContainer.x = (Config.WIDTH - btnContainer.width ) / 2;
		    btnContainer.y = (Config.HEIGHT - btnContainer.height ) / 2;
		}
		
		private function startNewGame():void
		{
		    dispatchEvent(new ViewEvent(ViewEvent.CHANGE_VIEW, {view:Constants.GAME_VIEW}, true))
		}
		
		private function continueGame():void
		{
		    dispatchEvent(new GameEvent(GameEvent.CONTINUE_GAME))
		}
				
		private function createBack():void 
		{	
		    backSprite = new Background(new GameModel());				
		    addChild(backSprite);            
		}	
	}	
}
