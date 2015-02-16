package components.fight {
	import components.cell.Body;
	import components.Enemy;
	import components.ui.SwapPanel;
	import components.Weapon;
	import flash.display.Graphics;
	import skills.anim.AnimFactory;
	import skills.anim.Animation;
	import flash.geom.Point;
	import flash.filters.DropShadowFilter;
	import flash.filters.BlurFilter;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	import model.*;
	import events.*;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import config.Config;
    import com.greensock.*
    import com.greensock.easing.*
    import utils.*;
	
	public class FightScreen extends Sprite 
	{
		
		private var _model:GameModel;
		private var _enemyVO:EnemyVO;
				
		private var bgBitmap:Bitmap;
		private var bgBmpd:BitmapData;
		private var backSprite:Sprite;
		
		private var playerWeaponContainer:WeaponSection;
		private var enemyWeaponContainer:WeaponSection;
		
		private var topPanel:Sprite;
		private var bottomPanel:Sprite;
		
		private var fightText:TextField;
		
		private var playerLife:LifeBar;
		private var enemyLife:LifeBar;
		
		public var playerAttacks:Array;
		public var enemyAttacks:Array;	
		public var playerLifeText:TextField;
		public var enemyLifeText:TextField;
		
		public var playerTimeBar:FightTimeBar;
		public var enemyTimeBar:FightTimeBar;
		
		public var playerAvatar:Avatar;
		public var enemyAvatar:Avatar;
		public var playerSprite:Body;
		public var enemySprite:Body;
			
		public var animationsFinished:Boolean;
		
		private var swapPanel:SwapPanel;
		
		public function FightScreen(model:GameModel, backBmd:BitmapData, enemyVO:EnemyVO):void 
		{	
		    _model = model;
		    _enemyVO = enemyVO;
			bgBmpd = backBmd;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
		    removeEventListener(Event.ADDED_TO_STAGE, init)
		    createBack();
		    createPlayer();
		    createEnemy();
		    fightText = TextUtil.createText({color:Config.C2, size:35, bold:true});
		    addChild(fightText);
		    fightText.text = "FIGHT!!!";	   		    
			fightText.x = (Config.WIDTH - fightText.width) / 2
			fightText.y = (Config.HEIGHT - fightText.height) / 2				
			fightText.alpha = 0;	    			
			
		    TweenMax.from(topPanel, .3, {x: -Config.WIDTH})
		    TweenMax.from(bottomPanel, .3, {x: Config.WIDTH})
		    TweenMax.to(fightText, .4, {delay:.5, alpha:.8, 
		                x:(Config.WIDTH - fightText.width*3) / 2,
		                y:(Config.HEIGHT - fightText.height*3) / 2,
		                ease:Strong.easeOut,
		                scaleX:3, scaleY:3}) 
		    TweenMax.to(fightText, .2, {delay:1, alpha:0, 
		                x: -Config.WIDTH,
		                blurFilter:{blurX:10, blurY:2, quality:3},
		                onComplete:removeText}) 
		}
		
		private function removeText():void
		{
		    if(fightText && contains(fightText))
		        removeChild(fightText)
		}
		
		private function createBack():void 
		{	
		    topPanel = new Sprite();
		    bottomPanel = new Sprite();
		    backSprite = new Sprite();
		    
            bgBitmap = new Bitmap(bgBmpd);
            addChild(bgBitmap); 
			
		    Draw.drawRoundRect(backSprite, 0, 0, Config.WIDTH, Config.HEIGHT, 10, 0x000000, .3)
			Draw.drawRoundRect(topPanel, 0, 0, Config.WIDTH, 100, 10, Config.C6, .3)			
			addChild(topPanel)
			topPanel.filters = [new DropShadowFilter(2, 45, 0, .5, 3, 3, 1, 3)];
			
			Draw.drawRoundRect(bottomPanel, 0, 0, Config.WIDTH, 100, 10, Config.C6, .3)	
			bottomPanel.y = Config.HEIGHT - 100;
			addChild(bottomPanel)
			bottomPanel.filters = [new DropShadowFilter(2, 45, 0, .5, 3, 3, 1, 3)];
						
			bgBmpd.draw(backSprite);
			bgBmpd.applyFilter(bgBmpd, bgBmpd.rect, new Point(), new BlurFilter(5, 5, 3))		
            
		}	
		
		private function createPlayer():void
		{				
			playerSprite = new Body(_model.player)
			addChild(playerSprite)
			playerSprite.x = playerSprite.width / 2 + 40;
			playerSprite.y = Config.HEIGHT/ 2;	
			playerSprite.rotation = 90;
			TweenMax.from(playerSprite, 1, {delay:1.5, x:-playerSprite.width, onComplete:letTheGamesBegin})
			
			playerTimeBar = new FightTimeBar();			
			playerTimeBar.x = 20
			playerTimeBar.y = playerSprite.y + playerSprite.height / 2 + 10;
			addChild(playerTimeBar)
			TweenMax.from(playerTimeBar, 1, {delay:1.5, x:-playerTimeBar.width})
						
			var levelText:TextField = TextUtil.createText({color:0x111111});
			addChild(levelText);
		    levelText.x = 28;
		    levelText.y = 73;
		    levelText.text = "Lvl: " + _model.player.level;
		    bottomPanel.addChild(levelText)	
		    
		    playerWeaponContainer = new WeaponSection(_model.player);
			playerWeaponContainer.clear();
			playerWeaponContainer.x = 105;
		    playerWeaponContainer.y = 5;
			bottomPanel.addChild(playerWeaponContainer)	    	
			
			playerAvatar = new Avatar(playerSprite);
			playerAvatar.x = playerWeaponContainer.x - playerAvatar.width - 10
			playerAvatar.y = playerWeaponContainer.y;
			bottomPanel.addChild(playerAvatar)			
		    
		    playerLife = new LifeBar(_model.player);	
			bottomPanel.addChild(playerLife);	
			playerLife.x = playerWeaponContainer.x;
			playerLife.y = playerWeaponContainer.y + playerWeaponContainer.height + 5;
		}
		
		private function createEnemy():void
		{		
		    topPanel.mouseChildren = false;			
			enemySprite = new Body(_enemyVO)
			addChild(enemySprite)
			enemySprite.rotation = -90;
			enemySprite.x = Config.WIDTH - enemySprite.width - 40;
			enemySprite.y = Config.HEIGHT/ 2;	
			TweenMax.from(enemySprite, 1, {delay:1.5, x:Config.WIDTH + enemySprite.width + enemySprite.height})
						
			enemyTimeBar = new FightTimeBar();
			addChild(enemyTimeBar)
			enemyTimeBar.x = Config.WIDTH - enemyTimeBar.width - 20;
			enemyTimeBar.y = enemySprite.y + enemySprite.height / 2 + 10;
			TweenMax.from(enemyTimeBar, 1, {delay:1.5, x:Config.WIDTH + enemyTimeBar.width * 2})
			
			var levelText:TextField = TextUtil.createText({color:0x111111});
			addChild(levelText);
		    levelText.x = Config.WIDTH - 72;
		    levelText.y = 73;
		    levelText.text = "Lvl: " + _enemyVO.level;
		    topPanel.addChild(levelText)			    
		    
		    enemyWeaponContainer = new WeaponSection(_enemyVO);
		    enemyWeaponContainer.clear();		
			enemyWeaponContainer.x = 165;
		    enemyWeaponContainer.y = 5; 
			topPanel.addChild(enemyWeaponContainer)	  
			
			enemyAvatar = new Avatar(enemySprite);
			topPanel.addChild(enemyAvatar)			
			enemyAvatar.x = enemyWeaponContainer.x + enemyWeaponContainer.width + 10;
			enemyAvatar.y = enemyWeaponContainer.y;
		    
			enemyLife = new LifeBar(_enemyVO);	
			topPanel.addChild(enemyLife);			
			enemyLife.x = enemyWeaponContainer.x;
			enemyLife.y = enemyWeaponContainer.y + enemyWeaponContainer.height + 5;
		}
		
		public function update():void
		{
			enemyLife.update();
			playerLife.update();
		}
		
		public function playAttackAnimation(target:String, weapon:Weapon):void
		{		
			var anim:Animation;					
			if(target == "enemy")
			{
				if(weapon.selectedForAttack)
					weapon.deselectForAttack();	
					
				anim = AnimFactory.getAnimation(weapon.weaponVO.skill, playerSprite, enemySprite)
			}
			else
			{
				anim = AnimFactory.getAnimation(weapon.weaponVO.skill, enemySprite, playerSprite)
			}
			animationsFinished = false;
			addChild(anim)
			anim.addEventListener(GameEvent.ANIM_OVER, removeAnim)
		}
		
		private function removeAnim(event:GameEvent):void
		{
			var obj:Sprite = Sprite(event.currentTarget);
		    if(obj && contains(obj))
		        removeChild(obj);
			
			update();
			
			animationsFinished = true;
		}
		
		/*public function updateLifeBars():void
		{
			if(enemyLife.scaleX != _enemyVO.currentHealth/_enemyVO.totalHealth)
				TweenMax.to(enemyLife, 1, {scaleX:_enemyVO.currentHealth/_enemyVO.totalHealth})  
			if(playerLife.scaleX != _model.player.currentHealth/_model.player.totalHealth)
		    	TweenMax.to(playerLife, 1, {scaleX:_model.player.currentHealth/_model.player.totalHealth}) 
		}*/
				
		private function letTheGamesBegin():void
		{
		    animationsFinished = true;
		}
		
		public function playEnd(callBack:Function):void
		{
		    fightText = TextUtil.createText({color:Config.C5, size:30, bold:true});
		    addChild(fightText);
		    fightText.text = "VICTORY!!!";	   		    
			fightText.x = (Config.WIDTH - fightText.width) / 2
			fightText.y = (Config.HEIGHT - fightText.height) / 2				
			fightText.alpha = 0;	    	
			
		    TweenMax.to(fightText, .4, {delay:.5, alpha:.8, 
		                x:(Config.WIDTH - fightText.width*3) / 2,
		                y:(Config.HEIGHT - fightText.height*3) / 2,
		                ease:Strong.easeOut,
		                scaleX:3, scaleY:3}) 
		    
		    TweenMax.to(fightText, .2, {delay:1.6, alpha:0, 
		                x: -Config.WIDTH,
		                blurFilter:{blurX:10, blurY:2, quality:3},
		                onComplete:addSwapScreen, onCompleteParams:[callBack]});
		}
		
		private function addSwapScreen(callBack:Function):void
		{
		    swapPanel = new SwapPanel(_model, _enemyVO, callBack);
		    addChild(swapPanel);
		    
		    for(var i:int = 0; i < _enemyVO.weapons.length; i++)
		    {		        
	            var weapon:Weapon = _enemyVO.weapons[i];
	            swapPanel.addEnemyWeapon(weapon);		        	      
		    }
		    
		    for(i = 0; i < _model.player.weapons.length; i++)
		    {		        
	            weapon = _model.player.weapons[i];
	            swapPanel.addPlayerWeapon(weapon);		        	      
		    }
		}
		
		public function clean():void
		{
		}
		
		public function gameOver(callBack:Function):void
		{
		    fightText = TextUtil.createText({color:Config.C2, size:11, bold:true});
		    addChild(fightText);
		    fightText.text = "GAME OVER :(\nTHE GAME WILL NOW RESTART :|";	   		    
			fightText.x = (Config.WIDTH - fightText.width) / 2
			fightText.y = (Config.HEIGHT - fightText.height) / 2				
			fightText.alpha = 0;	    	
			
		    TweenMax.to(fightText, .4, {delay:.5, alpha:.8, 
		                x:(Config.WIDTH - fightText.width*3) / 2,
		                y:(Config.HEIGHT - fightText.height*3) / 2,
		                ease:Strong.easeOut,
		                scaleX:3, scaleY:3}) 
		    TweenMax.to(fightText, .2, {delay:5, alpha:0, 
		                x: -Config.WIDTH, 
		                onComplete:callBack}) 		    
		}
		
	}	
}
