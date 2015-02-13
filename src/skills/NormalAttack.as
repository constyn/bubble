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
		
		public function applySkill(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{
			e1.currentHealth = Math.round(Math.min(e1.totalHealth, Math.max(0, e1.currentHealth)))
			e2.currentHealth = Math.round(Math.min(e2.totalHealth, Math.max(0, e2.currentHealth)))
		}
		
		public function toString():String
		{
			return "";
		}
	}
}
