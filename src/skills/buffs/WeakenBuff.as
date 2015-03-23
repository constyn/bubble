package skills.buffs {
	import model.EntityVO;

	/**
	 * @author taires
	 */
	public class WeakenBuff extends ABuff implements IBadBuff
	{
		public function WeakenBuff(e:EntityVO, amount:Number) 
		{
			super(e, amount);			
		}
		
	/*	override protected function addEffect():void
		{
			//enetity.weakEffect = amount;
		}
		
		override protected function removeffect():void
		{
			//enetity.weakEffect = 1;
		}*/
	}
}
