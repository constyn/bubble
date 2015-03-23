package skills.buffs {
	import model.EntityVO;
	import utils.NumUtil;

	/**
	 * @author taires
	 */
	public class ConcentrateBuff extends ABuff implements IGoodBuff
	{
		private var damageMulti:Number;
		
		public function ConcentrateBuff(e:EntityVO, amount:Number) 
		{
			super(e, amount);	
			damageMulti = NumUtil.range(0.3, 0.5) + amount / 100;
		}
		
		override public function applyBuff():void
		{
			ent.attackMultiplier *= damageMulti;
		}
		
	/*	override protected function addEffect():void
		{
			//enetity.attackEffect = amount;
		}
		
		override protected function removeffect():void
		{
			//enetity.attackEffect = 1;
		}*/
	}
}
