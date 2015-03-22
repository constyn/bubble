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
			skillVO.damage = range(0, level) + 40;
			skillVO.heal = skillVO.damage * range(1, level)/10;
			skillVO.name = "Drain";
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";							
			return toolTipText;
		}
	}
}
