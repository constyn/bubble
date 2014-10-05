package specials 
{
	import specials.buffs.SlowBuff;
	import specials.buffs.WeakenBuff;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Cold extends BaseSpecial
	{
		public function Cold(level:int, tier:int)
		{
			super(level, tier);
			specialVO = new SpecialVO();
			specialVO.coolDown = int(Math.random() * 3 + 2)
			specialVO.amount = int(Math.random() * level + 20);
			specialVO.name = "Frostbite";
		}
		
		override public function applySpecial(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e1.currentHealth = Math.round(Math.max(e1.currentHealth - (weaponVO.attack * e1.weakEffect), 0));
			e1.negBuffs.push(new SlowBuff(e1, specialVO.amount));			
			
			super.applySpecial(e1, e2, weaponVO);
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Slows opponent attack rate"
							
			return toolTipText;
		}
	}
}
