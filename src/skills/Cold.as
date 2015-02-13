package skills {
	import skills.buffs.SlowBuff;
	import model.SkillVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Cold extends NormalAttack
	{
		public function Cold(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SkillVO();
			//skillVO.coolDown = int(Math.random() * 3 + 2)
			//skillVO.amount = int(Math.random() * level + 20);
			skillVO.name = "Frostbite";
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Slows opponent attack rate"
							
			return toolTipText;
		}
	}
}
