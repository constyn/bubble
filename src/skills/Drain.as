package skills {
	import utils.TextUtil;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Drain extends BaseAttack
	{
		public function Drain(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SpecialVO();
			skillVO.coolDown = int(Math.random() * 3 + 2)
			skillVO.amount = int(Math.random() * level + 40);
			skillVO.name = "Drain";
		}
		
		override public function applySkill(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e1.currentHealth -= weaponVO.attack * e1.weakEffect;
			e2.currentHealth += skillVO.amount / 100 * weaponVO.attack;	
			
			super.applySkill(e1, e2, weaponVO);
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Heals for " + TextUtil.setHTMLColor(skillVO.amount + "%", skillAmountColor) + " of damage inflicted" 
							
			return toolTipText;
		}
	}
}
