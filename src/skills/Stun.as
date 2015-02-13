package skills {
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Stun extends BaseAttack
	{
		public function Stun(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SpecialVO();
			skillVO.doesDamage = false;
			skillVO.coolDown = int(Math.random() * 5 + 3)
			skillVO.amount = int(Math.random() * level + 5);
			skillVO.name = "Stun";
		}
		
		override public function applySkill(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e1.fightBarLoaded = 0;
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Opponents attack bar is reset";
							
			return toolTipText;
		}
	}
}
