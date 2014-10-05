package specials 
{
	import utils.TextUtil;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Power extends BaseSpecial
	{
		public function Power(level:int, tier:int)
		{
			super(level, tier);
			specialVO = new SpecialVO();
			specialVO.amount = int(Math.random() * 10 + 30);
			specialVO.coolDown = int(Math.random() * 5 + 4);
			specialVO.name = "Power Attack";			
		}
		
		override public function applySpecial(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e1.currentHealth -= weaponVO.attack * e1.weakEffect;
			e1.currentHealth -= weaponVO.attack * specialVO.amount / 100;				
			
			super.applySpecial(e1, e2, weaponVO);
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";			
			toolTipText += "Does " + TextUtil.setHTMLColor(specialVO.amount + "%", specialAmountColor) + " more damage"
							
			return toolTipText;
		}
	}
}
