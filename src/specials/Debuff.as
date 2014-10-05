package specials 
{
	import specials.buffs.PoisonBuff;
	import specials.buffs.WeakenBuff;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Debuff extends BaseSpecial
	{
		public function Debuff(level:int, tier:int)
		{
			super(level, tier);
			specialVO = new SpecialVO();			
			specialVO.doesDamage = false;
			specialVO.coolDown = int(Math.random() * 3 + 2)
			specialVO.amount = int(Math.random() * level + 1);
			specialVO.name = "Debuff";
		}
		
		override public function applySpecial(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e2.negBuffs = [];
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Removes all negative buffs";
							
			return toolTipText;
		}
	}
}
