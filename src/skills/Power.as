package skills {
	import utils.TextUtil;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Power extends BaseAttack
	{
		public function Power(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SpecialVO();
			skillVO.amount = int(Math.random() * 10 + 30);
			skillVO.coolDown = int(Math.random() * 5 + 4);
			skillVO.name = "Power Attack";			
		}
		
		override public function applySkill(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e1.currentHealth -= weaponVO.attack * e1.weakEffect;
			e1.currentHealth -= weaponVO.attack * skillVO.amount / 100;				
			
			super.applySkill(e1, e2, weaponVO);
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";			
			toolTipText += "Does " + TextUtil.setHTMLColor(skillVO.amount + "%", skillAmountColor) + " more damage"
							
			return toolTipText;
		}
	}
}
