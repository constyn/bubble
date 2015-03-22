package skills {
	import skills.buffs.PoisonBuff;
	import skills.buffs.WeakenBuff;
	import model.SkillVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Debuff extends NormalAttack
	{
		public function Debuff(level:int, tier:int)
		{
			super(level, tier);	
			skillVO = new SkillVO();
			//skillVO.coolDown = int(Math.random() * 3 + 2)
			//skillVO.amount = int(Math.random() * level + 1);
			skillVO.name = "Debuff";
		}
		
		override public function applySkill(attacker:EntityVO, target:EntityVO):void
		{
			attacker.buffs = [];
		}	
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Removes all negative buffs";
							
			return toolTipText;
		}
	}
}
