package skills {
	import utils.TextUtil;
	import model.SkillVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Heal extends NormalAttack
	{
		public function Heal(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SkillVO();
			skillVO.heal = range(2, 5) * level * (tier + 1);
			//skillVO.coolDown = int(Math.random() * 3 + 4 + tier)
			//skillVO.amount =
			skillVO.name = "Heal";
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Heals hit points.";
							
			return toolTipText;
		}
	}
}
