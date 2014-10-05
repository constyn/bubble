package specials 
{
	import utils.TextUtil;
	import specials.buffs.WeakenBuff;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Laser extends BaseSpecial
	{
		public function Laser(level:int, tier:int)
		{
			super(level, tier);
			specialVO = new SpecialVO();
			specialVO.coolDown = int(Math.random() * 3 + 2)
			specialVO.amount = int(Math.random() * 10 + 40);
			specialVO.name = "Laser Strike";
		}
		
		override public function applySpecial(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e1.currentHealth -= weaponVO.attack * e1.weakEffect;
			e1.negBuffs.push(new WeakenBuff(e1, specialVO.amount / 100 + 1));				
			
			super.applySpecial(e1, e2, weaponVO);
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Weakens the opponent by " + TextUtil.setHTMLColor(specialVO.amount + "%", specialAmountColor)
							
			return toolTipText;
		}
	}
}
