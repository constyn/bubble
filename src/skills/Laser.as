package skills {
	import utils.TextUtil;
	import skills.buffs.WeakenBuff;
	import model.SkillVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Laser extends NormalAttack
	{
		public function Laser(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SkillVO();
			//skillVO.coolDown = int(Math.random() * 3 + 2)
			//skillVO.amount = int(Math.random() * 10 + 40);
			skillVO.name = "Laser Strike";
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Weakens the opponent by ";
							
			return toolTipText;
		}
	}
}
