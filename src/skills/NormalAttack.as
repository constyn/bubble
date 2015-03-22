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
		protected var level:int;
		
		public function NormalAttack(level:int, tier:int)
		{
			this.level = level;
			skillVO = new SkillVO();
			skillVO.damage = range(20, level + 20);
			skillVO.name = "";
		}
		
		public function applySkill(attacker:EntityVO, target:EntityVO):void
		{
		}
		
		private function getCorrectedValue(e:EntityVO):int 
		{
			return Math.round(Math.min(e.totalHealth, Math.max(0, e.currentHealth)));
		}
		
		public function toString():String
		{
			return "";
		}
		
		protected function range(from:Number, to:Number):Number
		{
			return Math.random() * to + from;
		}
	}
}
