package components.menu
{
	import components.Weapon;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.text.*;
	import model.*;
    import config.Config;
    import flash.filters.*;
    import flash.geom.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import utils.*;
	
	public class SwapPanel extends Sprite 	
	{		
		private var _model:GameModel;
		private var enemyVO:EnemyVO;
		private var callBack:Function;
		private var backSprite:Sprite;
		private var titleText:TextField;
		private var continueBtn:TextButton;
		private var playerSelected:Weapon;
		private var enemySelected:Weapon;
		
		private var playerWeapons:Array;
		private var enemyWeapons:Array;
		
		public function SwapPanel(model:GameModel, enemyVO:EnemyVO, callBack:Function):void 
		{	
		    _model = model;
		    this.enemyVO = enemyVO;
		    this.callBack = callBack;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
		    removeEventListener(Event.ADDED_TO_STAGE, init)
		    backSprite = new Sprite()		    
	        addChild(backSprite);
	        playerWeapons = [];
	        enemyWeapons = [];
	        
	        backSprite.graphics.clear();	
			backSprite.graphics.lineStyle(2, Config.C6, 1)
		    backSprite.graphics.beginFill(0x333333, .3)
			backSprite.graphics.drawRect(0, 0, Config.WIDTH, Config.HEIGHT);
			backSprite.graphics.endFill();				
			backSprite.graphics.lineStyle(0, Config.C6, 0)
			Draw.drawRoundRect(backSprite, 50, 135, 540, 220, 5,0x333333, .8)			
			backSprite.graphics.lineStyle(2, Config.C6, 1)
			backSprite.graphics.beginFill(0x0, 0)
			backSprite.graphics.drawRoundRect(50, 134, 540, 220, 5, 5);
			backSprite.graphics.endFill();		
			backSprite.graphics.beginFill(0x333333, .8)
			backSprite.graphics.drawRect(50, 245, 540, 1);
			backSprite.graphics.endFill();		
			backSprite.graphics.beginFill(0xFFFFFF, .3)
			backSprite.graphics.drawRect(50, 246, 540, 1);
			backSprite.graphics.endFill();			
	       	backSprite.alpha = 0;	
	       	TweenMax.to(backSprite, .3, {alpha:1})
	       	
	       	continueBtn = new TextButton("Continue >", saveWeapons, null, [0xDDDDDD, Config.C5, Config.C6])
	       	addChild(continueBtn)
	       	continueBtn.alpha = 0;
	       	continueBtn.x = 600 - continueBtn.width;
	       	continueBtn.y = 365 - continueBtn.height;
	       	TweenMax.to(continueBtn, .5, {alpha:1})
	       	
	       	titleText = TextUtil.createText({size:14, color:0xDDDDDD});
	       	addChild(titleText);
	       	titleText.filters = [new BlurFilter(0,0,0)];
	       	titleText.alpha = 0;
	       	titleText.text = "Swap weapons with defeated enemy."
	       	titleText.x = 62;
	       	titleText.y = 333;
	       	TweenMax.to(titleText, .5, { alpha:1 } )
		
			filters = [new DropShadowFilter(3, 45, 0, .5, 4, 4)]
	    }
	    
	    public function addPlayerWeapon(weapon:Weapon):void
	    {	        
			addWeapon(weapon);
	        playerWeapons.push(weapon);
	        TweenMax.to(weapon, .5, {delay:Math.random()/3, x:"-50", y:275})	    
	    }
	    
	    public function addEnemyWeapon(weapon:Weapon):void
	    {
			addWeapon(weapon);
	        enemyWeapons.push(weapon); 
	        TweenMax.to(weapon, .5, {delay:Math.random()/2, x:"+50", y:165, ease:Back.easeOut})   	     
	    }
		
		private function addWeapon(weapon:Weapon):void
		{
			var point:Point = localToLocal(weapon.parent, this, new Point(weapon.x, weapon.y))
	        addChild(weapon)
	        weapon.x = point.x
	        weapon.y = point.y
			weapon.cleanUp();
			weapon.enable();	
	        weapon.animate = false;
	        weapon.setupListeners();    
	        weapon.addEventListener(MouseEvent.CLICK, selectWeapon)          
		}
	    
	    private function localToLocal(containerFrom:DisplayObject, containerTo:DisplayObject, origin:Point=null):Point
        {
            var point:Point = origin ? origin : new Point();
            point = containerFrom.localToGlobal(point);
            point = containerTo.globalToLocal(point);
            return point;
        }
             
        private function selectWeapon(event:MouseEvent):void
        {
            if( Weapon(event.currentTarget).disabled) return;
            
            if(enemyWeapons.indexOf(event.currentTarget) != -1)
            {
                if(enemySelected) enemySelected.deselect();
                
                if(enemySelected != Weapon(event.currentTarget))
                {
                    enemySelected = Weapon(event.currentTarget)
                    enemySelected.select();
                    
                    disableOthers(enemySelected.weaponVO.tier, playerWeapons, (enemyWeapons.indexOf(enemySelected) == 0))
                }
                else if(!playerSelected)
                {
                    enemySelected.deselect(); 
                    enableAll(playerWeapons); 
                    enemySelected = null;                 
                }
            }
            else if(playerWeapons.indexOf(event.currentTarget) != -1)
            {                
                if(playerSelected) playerSelected.deselect();
                
                if(playerSelected != Weapon(event.currentTarget))
                {
                    playerSelected = Weapon(event.currentTarget)
                    playerSelected.select();
                    
                    disableOthers(playerSelected.weaponVO.tier, enemyWeapons, playerWeapons.indexOf(playerSelected) == 0)
                }
                else if(!enemySelected)
                {
                    playerSelected.deselect(); 
                    enableAll(enemyWeapons); 
                    playerSelected = null;                      
                }
            }
                            
            if(enemySelected && playerSelected && !TweenMax.isTweening(enemySelected) && !TweenMax.isTweening(playerSelected))  
            {
                if(enemySelected.weaponVO.tier == playerSelected.weaponVO.tier)
                {
                    var playerIndex:int = playerWeapons.indexOf(playerSelected);
                    var enemyIndex:int = enemyWeapons.indexOf(enemySelected);
                    playerWeapons[playerIndex] = enemySelected;
                    enemyWeapons[enemyIndex] = playerSelected;
                    var point:Point = new Point(enemySelected.x, enemySelected.y)
                    TweenMax.to(enemySelected, .5, {x:playerSelected.x, y:playerSelected.y, ease:Back.easeOut})
                    TweenMax.to(playerSelected, .5, {x:point.x, y:point.y, ease:Back.easeOut })
                    enemySelected.deselect();
                    playerSelected.deselect();
                    enemySelected = null
                    playerSelected = null
                    enableAll(enemyWeapons)
                    enableAll(playerWeapons)
                }                
            }            
        }
        
        private function disableOthers(tier:int, weapons:Array, first:Boolean = false):void
        {
            for (var i:int=0; i < weapons.length; i++)
			{	
				var weapon:Weapon = weapons[i];
				
				if(i == 0 && first)		
					weapon.enable();
				else if(weapon.weaponVO.tier != tier || first)                
                    weapon.disable();
                else
                    weapon.enable();
			}
        }
        
        private function enableAll(weapons:Array):void
        {
            for each(var weapon:Weapon in weapons)
                weapon.enable();
        }        
           
        private function saveWeapons():void
        {
            for(var i:int = 0; i < _model.player.weapons.length; i++)
            {
	           	_model.player.weapons[i] = playerWeapons.shift();
            }
            callBack.apply()
        }
	}
}
