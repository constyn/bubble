package specials.buffs
{
	import model.EntityVO;

	/**
	 * @author taires
	 */
	public class ConcentrateBuff extends ABuff
	{
		
		public function ConcentrateBuff(ent:EntityVO, amount:Number) 
		{
			super(ent, amount);			
		}
		
		override protected function addEffect():void
		{
			enetity.attackEffect = amount;
		}
		
		override protected function removeffect():void
		{
			enetity.attackEffect = 1;
		}
	}
}
