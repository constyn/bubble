package skills {
	import skills.buffs.SlowBuff;
	import model.SkillVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Cold extends NormalAttack
	{
		public function Cold(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SkillVO();
			//skillVO.coolDown = range(2, 5);
			skillVO.damage = range(0, level) + 20;
			skillVO.name = "Frostbite";
		}
		
		override public function applySkill(attacker:EntityVO, target:EntityVO):void
		{
			target.buffs.push(new SlowBuff(target, level));
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Slows opponent attack rate"
							
			return toolTipText;
		}
	}
}
