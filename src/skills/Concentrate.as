package skills {
	import utils.TextUtil;
	import skills.buffs.ConcentrateBuff;
	import skills.buffs.WeakenBuff;
	import model.SkillVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Concentrate extends NormalAttack
	{
		public function Concentrate(level:int, tier:int)
		{
			super(level, tier);	
			skillVO = new SkillVO();
			//skillVO.coolDown = range(2, 5);
			skillVO.name = "Concentrate";
		}
		
		override public function applySkill(attacker:EntityVO, target:EntityVO):void
		{
			attacker.buffs.push(new ConcentrateBuff(level));
		}		
		
		override public function toString():String
		{
			var toolTipText:String = "";
			//toolTipText += "Makes next attack " + TextUtil.setHTMLColor(skillVO.amount + "%", skillAmountColor) +" stronger"
							
			return toolTipText;
		}
	}
}
