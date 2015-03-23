package managers 
{
	import skills.buffs.ABuff;
	import skills.NormalAttack;
	import model.SkillVO;
	import components.Weapon;
	import model.WeaponVO;
	import model.EntityVO;
	import utils.NumUtil;
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
				
				if(randWeapon){
					attack(entity2, entity1, randWeapon);
					if(entity1.currentHealth > 0)
					{
						randWeapon = getRandomWeapon(entity1);
						if (randWeapon)
						{
							attack(entity1, entity2, randWeapon);
							if(entity2.currentHealth <= 0)
								winner = 0
						}
					}
					else
					{
						winner = 1
					}
				}
			}
			
			if(!persist)
			{
				entity1.currentHealth = entity1.totalHealth; 
				entity2.currentHealth = entity2.totalHealth; 
			}
			entity1.fightBarLoaded = 0;
			entity2.fightBarLoaded = 0;
			entity1.buffs = [];
			entity2.buffs = [];
			
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
			return null;
		}
		
		public static function attack(attacker:EntityVO, target:EntityVO, weaponVO:WeaponVO):void
		{
			weaponVO.skill.applySkill(attacker, target);	
			
			var svo:SkillVO = weaponVO.skill.skillVO;
			
			for each(var buff:ABuff in attacker.buffs){
				buff.applyBuff()
			}
			
			for each(var buff2:ABuff in target.buffs){
				buff2.applyBuff()
			}
			
			if (svo.damage > 0){
				target.currentHealth = NumUtil.getCorrectedValue(target.totalHealth, target.currentHealth - svo.damage); 
			}
			if (svo.heal > 0){
				attacker.currentHealth =  NumUtil.getCorrectedValue(attacker.totalHealth, attacker.currentHealth + svo.heal);  
			}
			
			resetMultipliers(attacker);
			resetMultipliers(target);
		}
		
		static private function resetMultipliers(e:EntityVO):void {
			e.barSpeedMultiplier = 1;
			e.attackMultiplier = 1;
			e.weakenMultiplier = 1;
		}
		
		public function updateBuffs(ent:EntityVO):void
		{
			for each(var buff:ABuff in ent.buffs)
			{			
				if (buff.done)
				{
					ent.buffs.splice(ent.buffs.indexOf(buff), 1);
				}
				else	
				{
					buff.update();				
				}
			}
		}
	}	
}
