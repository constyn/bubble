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
			skillVO.doesDamage = true;			
			skillVO.damage = int(Math.random() * level + 1);
			skillVO.name = "Poison";
			var poisonBuff:PoisonBuff = new PoisonBuff(1);
			skillVO.opponentBuffs = [poisonBuff];			
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Poisons for some time for some time";
							
			return toolTipText;
		}
	}
}
