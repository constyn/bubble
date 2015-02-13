package skills {
	import utils.TextUtil;
	import skills.buffs.PoisonBuff;
	import skills.buffs.WeakenBuff;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Poison extends BaseAttack
	{
		public function Poison(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SpecialVO();
			skillVO.coolDown = int(Math.random() * 3 + 2)
			skillVO.amount = int(Math.random() * level + 1);
			skillVO.name = "Poison";
		}
		
		override public function applySkill(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e1.currentHealth -= weaponVO.attack * e1.weakEffect;
			e1.negBuffs.push(new PoisonBuff(e1, skillVO.amount));			
			
			super.applySkill(e1, e2, weaponVO);
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Drains " + TextUtil.setHTMLColor(String(skillVO.amount), skillAmountColor)+ " healt constantly for some time";
							
			return toolTipText;
		}
	}
}
