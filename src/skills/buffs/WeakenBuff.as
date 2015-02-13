package skills.buffs {
	import model.EntityVO;

	/**
	 * @author taires
	 */
	public class WeakenBuff extends ABuff
	{
		public function WeakenBuff(amount:Number) 
		{
			//super(ent, amount);			
		}
		
		override protected function addEffect():void
		{
			//enetity.weakEffect = amount;
		}
		
		override protected function removeffect():void
		{
			//enetity.weakEffect = 1;
		}
	}
}
