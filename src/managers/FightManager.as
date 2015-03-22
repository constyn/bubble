package managers
{
	import model.SkillVO;
	import events.GameEvent;
	import components.Weapon;
	import flash.events.MouseEvent;
	import components.Enemy;
	import components.Player;
	import components.fight.FightScreen;
	import model.GameModel;
	import flash.events.EventDispatcher;
	
	public class FightManager extends EventDispatcher
	{			    
		private var _model:GameModel;
		private var player:Player;
		private var enemy:Enemy;
		private var fightScreen:FightScreen;
		private var fightSim:FightSimulator;
		
		public function FightManager()
		{					
		    fightSim = new FightSimulator();
		}	
		
		public function setup(model:GameModel, player:Player, enemy:Enemy, fightScreen:FightScreen):void 
		{	
			this._model = model;
			this.player = player;
			this.enemy = enemy;
			this.fightScreen = fightScreen;
			
			for each(var weapon:Weapon in _model.player.weapons)
			{
			    weapon.setupListeners();
			    weapon.addEventListener(MouseEvent.CLICK, playerAttack)
			}
			
			fightScreen.addEventListener(GameEvent.ANIM_OVER, checkQueue)
			
			_model.player.fightBarLoaded = 0;
			enemy.enemyVO.fightBarLoaded = 0;
		}	
		
		public function playerAttack(event:MouseEvent):void
		{    
			if( _model.player.dead) 
				return;
			
		    var selectedWeapon:Weapon = Weapon(event.currentTarget);
		    if(selectedWeapon.weaponVO.coolDown > 0 || !selectedWeapon.enabled) 
		        return;
						
			if(!fightScreen.animationsFinished)
			{
				for each(var weapon:Weapon in _model.player.weapons)
					if(weapon.selectedForAttack)
						weapon.deselectForAttack();
			
				selectedWeapon.selectForAttack();
		        return;	
			}
			
			
		    _model.player.fightBarLoaded -= (selectedWeapon.weaponVO.tier + 1) * 33;
		    
			FightSimulator.attack(_model.player, enemy.enemyVO, selectedWeapon.weaponVO);	    
		   
		   	if(selectedWeapon.weaponVO.skill)
	        	selectedWeapon.weaponVO.coolDown = selectedWeapon.weaponVO.coolDown + 1;	   
		         
		    fightScreen.playAttackAnimation("enemy", Weapon(event.currentTarget)) 
		    
			for each(weapon in _model.player.weapons)
			{				
                if(weapon.weaponVO.coolDown != 0)
                    weapon.weaponVO.coolDown -=1;
			}
		}
		
		private function enemyAttack():void
		{     		
			var weapons:Array = enemy.enemyVO.weapons;
			
		    if(!weapons[0].enabled || enemy.dead)
		        return;
		         
	        var randWeapon:Weapon = weapons[int(weapons.length * Math.random())]
	        while(randWeapon.weaponVO.coolDown > 0 || !randWeapon.enabled)
	            randWeapon = weapons[int(weapons.length * Math.random())]
	        
			FightSimulator.attack(enemy.enemyVO, _model.player, randWeapon.weaponVO);
			
	        enemy.enemyVO.fightBarLoaded -= (randWeapon.weaponVO.tier + 1) * 33;    
	         	      
	        fightScreen.playAttackAnimation("player", randWeapon)	        
	          
			if(randWeapon.weaponVO.skill)
	        	randWeapon.weaponVO.coolDown = randWeapon.weaponVO.coolDown + 1;	    
			
	        for each(var weapon:Weapon in enemy.enemyVO.weapons)
	                if(weapon.weaponVO.coolDown != 0)
                        weapon.weaponVO.coolDown -=1;
		}
		
		
		private function checkQueue(event:GameEvent):void
		{
			for each(var weapon:Weapon in _model.player.weapons)
	        	if(weapon.selectedForAttack)
				{					
					weapon.dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, false, 10, 10))		
					return;
				}
		}
		
		public function update():void
		{   
		    if(enemy.dead || _model.player.dead) 
		    {
				fightScreen.clean();		    
			    return;
			}
			   
			for each(weapon in _model.player.weapons)
		        weapon.update(_model.player.fightBarLoaded);
					     
		    if(fightScreen.animationsFinished)
		    {					        
		        fightScreen.update(); 		       
		                
		        var lastTier:int = 1;
			    for each(weapon in enemy.enemyVO.weapons)
                {
                    lastTier = Math.max(lastTier, weapon.weaponVO.tier + 1);
                    weapon.update(enemy.enemyVO.fightBarLoaded);
                }			            
			            
			    if(Math.random() < .004 || enemy.enemyVO.fightBarLoaded >= 100||
			       lastTier * 33 + 1 < enemy.enemyVO.fightBarLoaded)
			    {
			        enemyAttack()     
			    }			    
			    
		        if(_model.player.fightBarLoaded < 100)
		        {        
		            _model.player.fightBarLoaded += _model.player.barLoadingSpeed * _model.player.barLoadingEffect;
		            fightScreen.playerTimeBar.update(_model.player.fightBarLoaded/100); 
								            
		        }
		        
		        if(enemy.enemyVO.fightBarLoaded < 100)
		        {        
		            enemy.enemyVO.fightBarLoaded += enemy.enemyVO.barLoadingSpeed * enemy.enemyVO.barLoadingEffect;
		            fightScreen.enemyTimeBar.update(enemy.enemyVO.fightBarLoaded/100); 
		        }
				
				fightSim.updateBuffs(_model.player);
				fightSim.updateBuffs(enemy.enemyVO);			    
			}
			
			if(_model.player.currentHealth <= 0 && !_model.player.dead)
	        {		  
	            _model.player.dead = true;          
	            fightScreen.gameOver(dispachGameOver);     
	        }
	        else if(enemy.enemyVO.currentHealth <= 0 && !enemy.dead)
	        {   		               
                _model.player.xp += Math.round(Math.pow(enemy.enemyVO.level, 1.7) + 30 + Math.random() * 5);
				
	            enemy.dead = true;
	            for each(var weapon:Weapon in _model.player.weapons)
				{
					weapon.removeEventListener(MouseEvent.CLICK, playerAttack)
	            	weapon.weaponVO.coolDown = 0;
				}
	           
	            fightScreen.playEnd(dispachGameEnd); 
	        }
		}
		
		public function dispachGameEnd():void
		{
		    dispatchEvent(new GameEvent(GameEvent.END_FIGHT))
		}
		
		public function dispachGameOver():void
		{
		    dispatchEvent(new GameEvent(GameEvent.GAME_OVER))
		}
		
	}	
}
