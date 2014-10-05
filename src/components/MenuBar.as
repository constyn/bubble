package components
{
	import utils.Draw;
	import utils.GameButton;
	import utils.TextUtil;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	import model.*;
    import config.Config;
	
	public class MenuBar extends Sprite 
	{		
		private const PADDING:int = 2;
		private const BAR_HEIGHT:int = 17;
		
		private var _model:GameModel;	
		private var lifeText:TextField;
	    private var lifeBar:Sprite;
		private var xpText:TextField;
	    private var xpBar:Sprite;
	    //private var soundButton:GameButton;

		private var playerHealth:Number;
		private var playerXP:Number;
		
		private var soundBtn:GameButton
		private var musicBtn:GameButton
		
		public function MenuBar(model:GameModel):void 
		{	
		    _model = model;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
		    removeEventListener(Event.ADDED_TO_STAGE, init)			
			drawMenuBar();	    
		}
		
		private function drawMenuBar():void
		{
			graphics.clear();
			graphics.beginFill(0x222222, .5)
			graphics.drawRect(0, 0, Config.WIDTH, 45);
			graphics.endFill();
									
			lifeBar = new Sprite();
			lifeBar.x = PADDING;
			lifeBar.y = PADDING + 3;			
			addChild(lifeBar)
			
			lifeText = TextUtil.createText({color:0x000001, size:12});
			addChild(lifeText)
			lifeText.x = lifeBar.x;
			lifeText.y = lifeBar.y;
			
			xpBar = new Sprite();			
			xpBar.x = PADDING;
			xpBar.y = PADDING + lifeBar.y + BAR_HEIGHT
			addChild(xpBar)
			
			xpText = TextUtil.createText({color:0x000001, size:12});
			addChild(xpText)
			xpText.x = xpBar.x;
			xpText.y = xpBar.y;
			
			soundBtn = new GameButton("Sound", stopSound)
			addChild(soundBtn);
			soundBtn.x = width - soundBtn.width - PADDING
			soundBtn.y = PADDING
			
			musicBtn = new GameButton("Music", stopMusic)
			addChild(musicBtn)
			musicBtn.x = soundBtn.x - soundBtn.width - PADDING
			musicBtn.y = PADDING
		}  
		
		private function stopMusic():void 
		{
			
		}
		
		private function stopSound():void 
		{
			
		}
		
		public function update():void
		{			
			if(playerHealth != _model.player.currentHealth)
			{
				playerHealth = _model.player.currentHealth;
				lifeText.text = "HP: " + playerHealth;
				lifeBar.graphics.clear();
				Draw.drawRoundRect(lifeBar, 0, 0, width / 3, BAR_HEIGHT, 4, Config.C6, .8)
				Draw.drawRoundRect(lifeBar, PADDING, PADDING, (width/3 - 2* PADDING) * Math.min(1, playerHealth/_model.player.totalHealth), BAR_HEIGHT - 2 * PADDING, 4, Config.C4, 1)			
				lifeBar.graphics.endFill();				
			}
			
			if(playerXP != _model.player.xp)
			{
				playerXP = _model.player.xp	
				var nextXP:int = _model.player.nextXPStep	
				xpText.text = "XP: " + playerXP;
				xpBar.graphics.clear();
				Draw.drawRoundRect(xpBar, 0, 0, width / 3, BAR_HEIGHT, 4, Config.C6, .8)
				
				var prevXP:int = Math.pow(_model.player.level, 0.5) * 100
				var xpProp:Number = 1- (nextXP - playerXP)/prevXP
				trace(playerXP, nextXP, prevXP, xpProp)
				Draw.drawRoundRect(xpBar, PADDING, PADDING, (width/3 - 2 * PADDING) * Math.min(1, xpProp), BAR_HEIGHT - 2 * PADDING, 4, Config.C4, 1)	
				
				xpBar.graphics.endFill();
			}
		}
	}	
}
