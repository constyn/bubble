package components.menu
{
	import components.cell.Body;
	import components.Enemy;
	import components.Weapon;
	import flash.display.Graphics;
	import specials.anim.AnimFactory;
	import specials.anim.Animation;
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
		
		private var playerWeaponContainer:Sprite;
		private var enemyWeaponContainer:Sprite;
		
		private var topPanel:Sprite;
		private var bottomPanel:Sprite;
		
		private var fightText:TextField;
		
		private var playerLife:Sprite;
		private var enemyLife:Sprite;		
		public var playerAttacks:Array;
		public var enemyAttacks:Array;	
		public var playerLifeText:TextField;
		public var enemyLifeText:TextField;
		
		public var playerTimeBar:FightTimeBar;
		public var enemyTimeBar:FightTimeBar;
		
		public var playerSprite:Body;
		public var enemySprite:Enemy;
			
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
			Draw.drawRoundRect(bottomPanel,5, 5, 90, 90, 5, Config.C1, .8)
			Draw.drawRoundRect(bottomPanel,10, 10, 80, 80, 4, 0xFFFFFF, .8)
			
			var playerBody:Body = new Body(_model.player)
			bottomPanel.addChild(playerBody)
			playerBody.scaleX = playerBody.scaleY = Math.min(1, Math.min(80/playerBody.width, 80/playerBody.height))
			playerBody.x = 50;
			playerBody.y = 50;
			
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
		    
		    playerWeaponContainer = new Sprite();
			playerWeaponContainer.graphics.clear();
			
			Draw.drawRoundRect(playerWeaponContainer, 0, 0, Config.WIDTH - 110, 70, 5, Config.C1, .8)			
			Draw.drawRoundRect(playerWeaponContainer, 5, 5, 170, 60, 4, 0xFFFFFF, .8)			
			Draw.drawRoundRect(playerWeaponContainer, 180, 5, 170, 60, 4, 0xFFFFFF, .8)						
			Draw.drawRoundRect(playerWeaponContainer, 355, 5, 170, 60, 4, 0xFFFFFF, .8)
			
			bottomPanel.addChild(playerWeaponContainer)
		    
		    playerAttacks = [];
			var counters:Array = [0,0,0];
		    for(var i:int = 0; i < _model.player.weapons.length; i++)
		    {	       
	            var weapon:Weapon = _model.player.weapons[i];
	            playerWeaponContainer.addChild(weapon);				
	            weapon.x = 10 + (weapon.width + 5) * counters[weapon.weaponVO.tier] + weapon.weaponVO.tier * 175;
	            weapon.y = 10;
				counters[weapon.weaponVO.tier]++;
	            playerAttacks.push(weapon);		        				        
		    }
		    
		    playerWeaponContainer.x = 105;
		    playerWeaponContainer.y = 5;	   
		    
		    playerLife = new Sprite()								
			Draw.drawRoundRect(playerLife, 0, 0, Config.WIDTH - 110, 15, 4, Config.C4, .8)
			playerLife.x = 105;
			playerLife.y = 80;
			playerLife.scaleX = _model.player.currentHealth/_model.player.totalHealth
			bottomPanel.addChild(playerLife)
			TweenMax.from(playerLife, 1, {delay:1, scaleX:0})			
			
			playerLifeText = TextUtil.createText({color:0x111111});
			addChild(playerLifeText);
		    playerLifeText.x = 105;
		    playerLifeText.y = 78;
		    playerLifeText.text = "Health: " + _model.player.currentHealth;
		    bottomPanel.addChild(playerLifeText)
		}
		
		private function createEnemy():void
		{		
		    topPanel.mouseChildren = false;
			Draw.drawRoundRect(topPanel, Config.WIDTH - 95, 5, 90, 90, 5, Config.C1, .8)
			Draw.drawRoundRect(topPanel, Config.WIDTH - 90, 10, 80, 80, 4, 0xFFFFFF, .8)
			
			var enemy:Enemy = new Enemy(_enemyVO)
			topPanel.addChild(enemy)			
			enemy.scaleX = enemy.scaleY = Math.min(1, Math.min(80/enemy.width, 80/enemy.height))
			enemy.x = Config.WIDTH - 50
			enemy.y = 50
			
			enemySprite = new Enemy(_enemyVO)
			enemySprite.enemyVO = _enemyVO
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
		    
		    enemyWeaponContainer = new Sprite();
		    enemyWeaponContainer.graphics.clear();			
			
			Draw.drawRoundRect(enemyWeaponContainer, 0, 0, Config.WIDTH - 110, 70, 5, Config.C1, .8)
			Draw.drawRoundRect(enemyWeaponContainer, 5, 5, 170, 60, 4, 0xFFFFFF, .8)
			Draw.drawRoundRect(enemyWeaponContainer, 180, 5, 170, 60, 4, 0xFFFFFF, .8)
			Draw.drawRoundRect(enemyWeaponContainer, 355, 5, 170, 60, 4, 0xFFFFFF, .8)
			
			topPanel.addChild(enemyWeaponContainer)
		    
		    enemyWeaponContainer.x = 5;
		    enemyWeaponContainer.y = 5;
		    
		    enemyAttacks = [];
			var counters:Array = [0,0,0];
		    for(var i:int = 0; i < _enemyVO.weapons.length; i++)
		    {
	            var weapon:Weapon = _enemyVO.weapons[i];
	            enemyWeaponContainer.addChild(weapon);
	            weapon.x = 10 + (weapon.width + 5) * counters[weapon.weaponVO.tier] + weapon.weaponVO.tier * 175;
	            weapon.y = 10;
				counters[weapon.weaponVO.tier]++;
	            enemyAttacks.push(weapon);
		    }
		    
		    enemyLife = new Sprite();			
			Draw.drawRoundRect(enemyLife, 0, 0, Config.WIDTH - 110, 15, 4, Config.C4, .8)
			enemyLife.x = 5;
			enemyLife.y = 80;
			enemyLife.scaleX = _enemyVO.currentHealth/_enemyVO.totalHealth;
			topPanel.addChild(enemyLife)			
			TweenMax.from(enemyLife, 1, {delay:1, scaleX:0})
						
			enemyLifeText = TextUtil.createText({color:0x111111});
			addChild(enemyLifeText);
		    enemyLifeText.x = 10;
		    enemyLifeText.y = 78;
		    enemyLifeText.text = "Health: " + _enemyVO.currentHealth;
		    topPanel.addChild(enemyLifeText)	  
		}
		
		public function update():void
		{
		    playerLifeText.text = "Health: " + _model.player.currentHealth;
		    enemyLifeText.text = "Health: " + _enemyVO.currentHealth;
			updateLifeBars();
		}
		
		public function playAttackAnimation(target:String, weapon:Weapon):void
		{		
			var anim:Animation;					
			if(target == "enemy")
			{
				if(weapon.selectedForAttack)
					weapon.deselectForAttack();	
					
				anim = AnimFactory.getAnimation(weapon.weaponVO.special, playerSprite, enemySprite)
			}
			else
			{
				anim = AnimFactory.getAnimation(weapon.weaponVO.special, enemySprite, playerSprite)
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
			
			updateLifeBars();
			
			animationsFinished = true;
		}
		
		public function updateLifeBars():void
		{
			if(enemyLife.scaleX != _enemyVO.currentHealth/_enemyVO.totalHealth)
				TweenMax.to(enemyLife, 1, {scaleX:_enemyVO.currentHealth/_enemyVO.totalHealth})  
			if(playerLife.scaleX != _model.player.currentHealth/_model.player.totalHealth)
		    	TweenMax.to(playerLife, 1, {scaleX:_model.player.currentHealth/_model.player.totalHealth}) 
		}
				
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
