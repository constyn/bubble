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
			skillVO.doesDamage = false;
			//skillVO.coolDown = int(Math.random() * 3 + 2)
			//skillVO.amount = int(Math.random() * level + 40);
			skillVO.name = "Concentrate";
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			//toolTipText += "Makes next attack " + TextUtil.setHTMLColor(skillVO.amount + "%", skillAmountColor) +" stronger"
							
			return toolTipText;
		}
	}
}
