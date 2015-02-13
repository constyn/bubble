package skills {
	import utils.TextUtil;
	import skills.buffs.ConcentrateBuff;
	import skills.buffs.WeakenBuff;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Concentrate extends BaseAttack
	{
		public function Concentrate(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SpecialVO();			
			skillVO.doesDamage = false;
			skillVO.coolDown = int(Math.random() * 3 + 2)
			skillVO.amount = int(Math.random() * level + 40);
			skillVO.name = "Concentrate";
		}
		
		override public function applySkill(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e2.pozBuffs.push(new ConcentrateBuff(e1, 1 + skillVO.amount/100));		
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Makes next attack " + TextUtil.setHTMLColor(skillVO.amount + "%", skillAmountColor) +" stronger"
							
			return toolTipText;
		}
	}
}
