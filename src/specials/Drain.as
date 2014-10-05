package specials 
{
	import utils.TextUtil;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Drain extends BaseSpecial
	{
		public function Drain(level:int, tier:int)
		{
			super(level, tier);
			specialVO = new SpecialVO();
			specialVO.coolDown = int(Math.random() * 3 + 2)
			specialVO.amount = int(Math.random() * level + 40);
			specialVO.name = "Drain";
		}
		
		override public function applySpecial(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e1.currentHealth -= weaponVO.attack * e1.weakEffect;
			e2.currentHealth += specialVO.amount / 100 * weaponVO.attack;	
			
			super.applySpecial(e1, e2, weaponVO);
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Heals for " + TextUtil.setHTMLColor(specialVO.amount + "%", specialAmountColor) + " of damage inflicted" 
							
			return toolTipText;
		}
	}
}
