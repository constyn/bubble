package specials 
{
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Stun extends BaseSpecial
	{
		public function Stun(level:int, tier:int)
		{
			super(level, tier);
			specialVO = new SpecialVO();
			specialVO.doesDamage = false;
			specialVO.coolDown = int(Math.random() * 5 + 3)
			specialVO.amount = int(Math.random() * level + 5);
			specialVO.name = "Stun";
		}
		
		override public function applySpecial(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
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
