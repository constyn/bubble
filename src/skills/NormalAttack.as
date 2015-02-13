package skills {
	import config.Config;
	import model.SkillVO;
	import model.EntityVO;
	import model.WeaponVO;
	/**
	 * @author taires
	 */
	public class NormalAttack 
	{
		public var skillVO:SkillVO;
		public var skillAmountColor:uint = Config.C5;
		
		public function NormalAttack(level:int, tier:int)
		{
			
		}
		
		public function applySkill(attacker:EntityVO, target:EntityVO):void
		{
			if (skillVO.doesDamage)
			{
				target.currentHealth -= skillVO.damage;
				target.currentHealth = getCorrectedValue(target); 
			}
			if (skillVO.lifeRecovery)
			{
				attacker.currentHealth += skillVO.heal;
				attacker.currentHealth = getCorrectedValue(attacker); 
			}
		}
		
		private function getCorrectedValue(e:EntityVO):int 
		{
			return Math.round(Math.min(e.totalHealth, Math.max(0, e.currentHealth)));
		}
		
		public function toString():String
		{
			return "";
		}
	}
}
