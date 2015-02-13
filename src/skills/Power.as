package skills {
	import utils.TextUtil;
	import model.SkillVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Power extends NormalAttack
	{
		public function Power(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SkillVO();
			skillVO.name = "Power Attack";			
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";			
			toolTipText += "Does more damage"
							
			return toolTipText;
		}
	}
}
