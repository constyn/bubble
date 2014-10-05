package specials 
{
	import utils.TextUtil;
	import specials.buffs.PoisonBuff;
	import specials.buffs.WeakenBuff;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Poison extends BaseSpecial
	{
		public function Poison(level:int, tier:int)
		{
			super(level, tier);
			specialVO = new SpecialVO();
			specialVO.coolDown = int(Math.random() * 3 + 2)
			specialVO.amount = int(Math.random() * level + 1);
			specialVO.name = "Poison";
		}
		
		override public function applySpecial(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e1.currentHealth -= weaponVO.attack * e1.weakEffect;
			e1.negBuffs.push(new PoisonBuff(e1, specialVO.amount));			
			
			super.applySpecial(e1, e2, weaponVO);
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Drains " + TextUtil.setHTMLColor(String(specialVO.amount), specialAmountColor)+ " healt constantly for some time";
							
			return toolTipText;
		}
	}
}
