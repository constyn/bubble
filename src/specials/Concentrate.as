package specials 
{
	import utils.TextUtil;
	import specials.buffs.ConcentrateBuff;
	import specials.buffs.WeakenBuff;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Concentrate extends BaseSpecial
	{
		public function Concentrate(level:int, tier:int)
		{
			super(level, tier);
			specialVO = new SpecialVO();			
			specialVO.doesDamage = false;
			specialVO.coolDown = int(Math.random() * 3 + 2)
			specialVO.amount = int(Math.random() * level + 40);
			specialVO.name = "Concentrate";
		}
		
		override public function applySpecial(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e2.pozBuffs.push(new ConcentrateBuff(e1, 1 + specialVO.amount/100));		
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Makes next attack " + TextUtil.setHTMLColor(specialVO.amount + "%", specialAmountColor) +" stronger"
							
			return toolTipText;
		}
	}
}
