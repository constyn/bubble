package skills {
	import utils.TextUtil;
	import skills.buffs.PoisonBuff;
	import model.SkillVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Poison extends NormalAttack
	{
		public function Poison(level:int, tier:int)
		{
			super(level, tier);	
			skillVO = new SkillVO();
			skillVO.damage = int(Math.random() * level + 1);
			skillVO.name = "Poison";		
		}
		
		override public function applySkill(attacker:EntityVO, target:EntityVO):void
		{			
			var poisonBuff:PoisonBuff = new PoisonBuff(level);
			target.buffs.push(poisonBuff)
		}	
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Poisons for some time for some time";
							
			return toolTipText;
		}
	}
}
