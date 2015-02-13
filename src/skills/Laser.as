package skills {
	import utils.TextUtil;
	import skills.buffs.WeakenBuff;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Laser extends BaseAttack
	{
		public function Laser(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SpecialVO();
			skillVO.coolDown = int(Math.random() * 3 + 2)
			skillVO.amount = int(Math.random() * 10 + 40);
			skillVO.name = "Laser Strike";
		}
		
		override public function applySkill(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e1.currentHealth -= weaponVO.attack * e1.weakEffect;
			e1.negBuffs.push(new WeakenBuff(e1, skillVO.amount / 100 + 1));				
			
			super.applySkill(e1, e2, weaponVO);
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Weakens the opponent by " + TextUtil.setHTMLColor(skillVO.amount + "%", skillAmountColor)
							
			return toolTipText;
		}
	}
}
