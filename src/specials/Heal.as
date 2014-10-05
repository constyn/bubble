package specials 
{
	import utils.TextUtil;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Heal extends BaseSpecial
	{
		public function Heal(level:int, tier:int)
		{
			super(level, tier);
			specialVO = new SpecialVO();
			specialVO.doesDamage = false;
			specialVO.coolDown = int(Math.random() * 3 + 4 + tier)
			specialVO.amount = (Math.round(Math.random() * 3) + 2) * level * (tier + 1);
			specialVO.name = "Heal";
		}
		
		override public function applySpecial(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e2.currentHealth += specialVO.amount			
			super.applySpecial(e1, e2, weaponVO)
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Heals " + TextUtil.setHTMLColor(specialVO.amount.toString(), specialAmountColor) + " hit points.";
							
			return toolTipText;
		}
	}
}
