package skills.buffs {
	import model.EntityVO;

	/**
	 * @author taires
	 */
	public class ConcentrateBuff extends ABuff
	{
		
		public function ConcentrateBuff(amount:Number) 
		{
			//super(ent, amount);			
		}
		
		override protected function addEffect():void
		{
			//enetity.attackEffect = amount;
		}
		
		override protected function removeffect():void
		{
			//enetity.attackEffect = 1;
		}
	}
}
