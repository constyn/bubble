package managers 
{
	import skills.buffs.ABuff;
	import skills.NormalAttack;
	import model.SkillVO;
	import components.Weapon;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class FightSimulator 
	{
		public function FightSimulator()
		{
			
		}
				
		public function simulate(entity1:EntityVO, entity2:EntityVO, persist:Boolean = false):Number
		{
			var winner:int = -1;
			while(winner == -1)
			{
				var randWeapon:WeaponVO = getRandomWeapon(entity2);
				
				attack(entity1, entity2, randWeapon)
				if(entity1.currentHealth > 0)
				{
					randWeapon = getRandomWeapon(entity1);
					attack(entity2, entity1, randWeapon)
					if(entity2.currentHealth <= 0)
						winner = 0
				}
				else
				{
					winner = 1
				}
			}
			
			if(!persist)
			{
				entity1.currentHealth = entity1.totalHealth; 
				entity2.currentHealth = entity2.totalHealth; 
			}
			entity1.fightBarLoaded = 0;
			entity2.fightBarLoaded = 0;
			entity1.negBuffs = [];
			entity1.pozBuffs = [];
			entity2.negBuffs = [];
			entity2.pozBuffs = [];
			
			return winner;
		}
		
		private function getRandomWeapon(entity:EntityVO):WeaponVO
		{			 
			entity.fightBarLoaded++;	
			updateBuffs(entity);	
			var currentTier:int = int(entity.fightBarLoaded / 33);
						
			if(currentTier > 0 && (Math.random() < .1 || currentTier == 2))
			{	
				var weapon:Weapon = entity.weapons[int(Math.random() * entity.weapons.length)];
				while(weapon.weaponVO.tier >= currentTier)
					weapon = entity.weapons[int(Math.random() * entity.weapons.length)];
				
				entity.fightBarLoaded -= 33 * (weapon.weaponVO.tier	+ 1)
				return  weapon.weaponVO;
			}
			else
			{
				return new WeaponVO();
			}
		}
		
		public static function attack(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{
			if(weaponVO.skill)
				weaponVO.skill.applySkill(e1, e2, weaponVO);
			else	     
	        	e1.currentHealth = Math.max(e1.currentHealth - (weaponVO.damage * e1.weakEffect), 0); 	        
		}
		
		public function updateBuffs(ent:EntityVO):void
		{
			for each(var buff:ABuff in ent.negBuffs)
				buff.update();
				
			for each(buff in ent.pozBuffs)
				buff.update();
		}
	}	
}
