package skills {
	import skills.buffs.SlowBuff;
	import model.SpecialVO;
	import model.WeaponVO;
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class Cold extends BaseAttack
	{
		public function Cold(level:int, tier:int)
		{
			super(level, tier);
			skillVO = new SpecialVO();
			skillVO.coolDown = int(Math.random() * 3 + 2)
			skillVO.amount = int(Math.random() * level + 20);
			skillVO.name = "Frostbite";
		}
		
		override public function applySkill(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{	
			e1.currentHealth = Math.round(Math.max(e1.currentHealth - (weaponVO.attack * e1.weakEffect), 0));
			e1.negBuffs.push(new SlowBuff(e1, skillVO.amount));			
			
			super.applySkill(e1, e2, weaponVO);
		}
		
		override public function toString():String
		{
			var toolTipText:String = "";
			toolTipText += "Slows opponent attack rate"
							
			return toolTipText;
		}
	}
}
