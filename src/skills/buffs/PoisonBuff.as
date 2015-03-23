package skills.buffs {
	import model.EntityVO;
	import utils.NumUtil;

	/**
	 * @author taires
	 */
	public class PoisonBuff extends ABuff implements IBadBuff
	{
		private var healthPerTick:int;
		
		public function PoisonBuff(e:EntityVO, amount:Number) 
		{
			super(e, amount);	
			healthPerTick = 1;
		}
		
		override public function onTick():void
		{
			ent.currentHealth = NumUtil.getCorrectedValue(ent.totalHealth, ent.currentHealth - healthPerTick);
		}
	}
}
