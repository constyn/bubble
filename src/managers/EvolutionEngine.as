package managers
{
	import config.Config;
	import flash.geom.Point;
    import skills.*
    import flash.display.Sprite;
    import genetic.Generator;
    import model.*
    import components.*
	
	public class EvolutionEngine extends Sprite
	{		
		private const SPECIALS:Array = [
									   [Concentrate, Concentrate, Concentrate],
									   [Power, Concentrate, Drain, Heal, Laser, Cold, Stun],
									   [Power, Drain, Heal, Laser, Cold, Poison]]
							
		private var weaponFirstName:Array = ["Magnificent", "Ultra", "Hyper", "Super", "Uber", "Anti", "Giga", "Mega", "Ancient",
										   	 "Micro", "Mini", "Nano", "Great", "Glamorous", "Massive", "Happy", "Trendy", "Scarry", 
											 "Grim", "Evil", "Big", "Angry", "Colossal", "Fat", "Large", "Silly", "Clumsy", "Fancy",
											 "Cold", "Hot", "Gay", "Weak", "Small"]
		private var weaponSecondName:Array = ["Ninja", "Monkey", "Pirate", "Zombie", "Penguin", "Alien", "Bubble", "Rabbit", 
											  "Banana", "Robot", "Unicorn", "Farry", "Panda", "Virus", "Monster"]
		//private const SPECIALS:Array = [Power, Poison, Concentrate, Stun]
			    
		private var _model:GameModel;
		private var entityPool:Array;
		private var popSize:int = 10;
		private var generator:Generator;
		private var fightSim:FightSimulator;
		private var battleSelection:Array;		
				
		public function EvolutionEngine()
		{						
		}	
		
		public function setup(model:GameModel):void 
		{	
			this._model = model;
			generator = new Generator();
			fightSim = new FightSimulator();
			fillPool();
			battleSelection = [];
			//addEventListener(Event.ENTER_FRAME, step)
		}
		
		private function fillPool():void
		{
			entityPool = [];
			for(var i:int = 0; i < popSize; i++)
			{
				var enemyVO:EnemyVO = createEnemy();
		        entityPool.push(enemyVO);
			}
		}
		
		private function createEnemy():EnemyVO
		{
			var enemyVO:EnemyVO = new EnemyVO();
                
	        enemyVO.level = Math.max(Math.round(Math.random() * 2) - 1  + _model.player.level, 1)
            enemyVO.cellArray = [];
            enemyVO.totalHealth = 0;
			enemyVO.fitness = 0;
			enemyVO.buffs = [];
            createCells(enemyVO);		        
	        createWeapons(enemyVO);
			//enemyVO.actions = generator.generateActions(enemyVO)
			
			return enemyVO;
		}
		
		private function step():void
		{				
			if(battleSelection.length > 2)
			{
				var e1:EnemyVO = battleSelection.shift();
				var e2:EnemyVO = battleSelection.shift();
				if(fightSim.simulate(e1, e2) == 0)
				{					
					e2.fitness += e1.fitness + 1;
					battleSelection = battleSelection.concat(e2);
				}
				else
				{					
					e1.fitness += e2.fitness + 1;
					battleSelection = battleSelection.concat(e1);
				}		
			}
			else
			{
				entityPool.sortOn("fitness");
				
				for(i = int(popSize/2); i < entityPool.length; i++) 
				{
					entityPool[i] = createEnemy();
				}
				
				for(var i:int = 0; i < entityPool.length; i++)
				{
					var ent:EntityVO = entityPool[i];
					ent.fitness = 0;
					battleSelection.push(ent);
				}				
			}			
		}
		
		public function update():void
		{   
		    generateSutableEnemies()
		    generateNutrients();
		}
		
		private function generateSutableEnemies():void
		{
            if(Math.random() < .1 && _model.enemies.length < 10)
            {				
                var enemyVO:EnemyVO = entityPool.shift();
				entityPool.push(createEnemy())
		        _model.enemies.push(enemyVO);
            } 
			else
			{
				//step();                    
			}
		}
		
		private function createCells(vo:EntityVO):void
		{
		    for(var j:int = 0; j < vo.level; j++)
            {
               createCell(vo);
            }
		}	
		
		public function createCell(vo:EntityVO):void
		{		
			var colorArr:Array = [Config.C5, Config.C2, Config.C1, Config.C4]//, Config.C5, Config.C2, Config.C4]
			var cellRadius:Number = Math.round(Math.random() * 5 + 9);     
			var randColor:Number = colorArr[int(Math.random() * colorArr.length)]; 
			var cellVO1:CellVO = new CellVO();
			var cellVO2:CellVO = new CellVO();
			cellVO1.radius = cellRadius;
			cellVO2.radius = cellRadius;
			cellVO1.color = randColor;	
			cellVO2.color = randColor;                
			var randRadius:Number = cellRadius * Math.random() * (vo.level)     
			var angle:Number = Math.random() * 180;
			
			if (vo.cellArray.length >= 2) {
				
				var prevCell1:CellVO = vo.cellArray[vo.cellArray.length-1];
				var prevCell2:CellVO = vo.cellArray[vo.cellArray.length-2];
				cellVO1.relativeX = Math.sin(angle) * prevCell1.radius + prevCell1.relativeX;
				cellVO1.relativeY = Math.cos(angle) * prevCell1.radius + prevCell1.relativeY;
				cellVO2.relativeX = Math.sin(-angle) * prevCell1.radius + prevCell2.relativeX;
				cellVO2.relativeY = Math.cos(-angle) * prevCell1.radius + prevCell2.relativeY;  	
			}
            else {				
				cellVO1.relativeX = 0;
				cellVO1.relativeY = 0;
				cellVO2.relativeX = 0;
				cellVO2.relativeY = 0;  	
			}
			
			vo.cellArray.push(cellVO1); 
			vo.cellArray.push(cellVO2); 
			
			vo.totalHealth += cellRadius * 5;
			vo.currentHealth = vo.totalHealth;
		}
		
		private function getProximityPos(cells:Array):void
		{
			
			for each(var cell:CellVO in cells) {
				
			}
		}
		
		private function distance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			return(Math.sqrt(Math.pow(x2-x1, 2)+Math.pow(y2-y1,2)))
		}
		
		private function generateNutrients():void
		{
		    if(Math.random() < .1 && _model.nutrients.length < 10)
		    {
		        var nutriVO:NutrientVO = new NutrientVO();
	            nutriVO.energy = 5;
		        _model.nutrients.push(nutriVO);  
		    }
		}
		
		private function createWeapons(entity:EntityVO):void
		{			
		    for(var i:int = 0; i < Math.min(9, entity.level); i++)
	        {
	            var weapon:Weapon = getSutableWeapon(entity, i)
	            entity.weapons.push(weapon);  
	        }
		} 
		
		public function getSutableWeapon(entity:EntityVO, index:int):Weapon
		{
			var weaponLevels:Array = [1, 2.5, 4];
			var weaponVO:WeaponVO = new WeaponVO();
			var skill:NormalAttack;
			weaponVO.tier = index % 3;				
	     
	        if(index != 0)
			{					
				var skillArr:Array = SPECIALS[weaponVO.tier];
				skill = new skillArr[int(skillArr.length * Math.random())](entity.level, weaponVO.tier);
	        	weaponVO.skill = skill;
			}
			else
			{
				skill = new NormalAttack(entity.level, weaponVO.tier);
				if(entity is PlayerVO) skill.skillVO.damage = 2000;
	        	weaponVO.skill = skill;
			}			
			
			weaponVO.name = weaponFirstName[int(weaponFirstName.length * Math.random())] + " " +
							weaponFirstName[int(weaponFirstName.length * Math.random())] + " " +
							weaponSecondName[int(weaponSecondName.length * Math.random())];			
				
			var weapon:Weapon = new Weapon(weaponVO);
			return weapon;
		}
		
	}
}
