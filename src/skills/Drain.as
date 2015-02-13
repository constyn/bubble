package skills {
	import utils.TextUtil;
	import model.SkillVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Drain extends NormalAttack
	{
		public function Drain(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SkillVO();
			//skillVO.coolDown = int(Math.random() * 3 + 2)
			//skillVO.amount = int(Math.random() * level + 40);
			skillVO.name = "Drain";
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			//toolTipText += "Heals for " + TextUtil.setHTMLColor(skillVO.amount + "%", skillAmountColor) + " of damage inflicted" 
							
			return toolTipText;
		}
	}
}
