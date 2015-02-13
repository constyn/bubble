package skills {
	import utils.TextUtil;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Heal extends BaseAttack
	{
		public function Heal(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SpecialVO();
			skillVO.doesDamage = false;
			skillVO.coolDown = int(Math.random() * 3 + 4 + tier)
			skillVO.amount = (Math.round(Math.random() * 3) + 2) * level * (tier + 1);
			skillVO.name = "Heal";
		}
		
		override public function applySkill(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e2.currentHealth += skillVO.amount			
			super.applySkill(e1, e2, weaponVO)
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Heals " + TextUtil.setHTMLColor(skillVO.amount.toString(), skillAmountColor) + " hit points.";
							
			return toolTipText;
		}
	}
}
