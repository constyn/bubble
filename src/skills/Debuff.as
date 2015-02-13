package skills {
	import skills.buffs.PoisonBuff;
	import skills.buffs.WeakenBuff;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Debuff extends BaseAttack
	{
		public function Debuff(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SpecialVO();			
			skillVO.doesDamage = false;
			skillVO.coolDown = int(Math.random() * 3 + 2)
			skillVO.amount = int(Math.random() * level + 1);
			skillVO.name = "Debuff";
		}
		
		override public function applySkill(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e2.negBuffs = [];
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Removes all negative buffs";
							
			return toolTipText;
		}
	}
}
