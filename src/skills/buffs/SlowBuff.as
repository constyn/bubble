package skills.buffs {import model.EntityVO;
	/**
	 * @author taires
	 */
	public class SlowBuff extends ABuff implements IBadBuff
	{		
		public function SlowBuff(e:EntityVO, amount:Number) 
		{
			super(e, amount);	
		}
		
	/*	override protected function addEffect():void
		{
			//enetity.barLoadingEffect = .7;
		}
		
		override protected function removeffect():void
		{
			//enetity.barLoadingEffect = 1;
		}*/
	}
}
