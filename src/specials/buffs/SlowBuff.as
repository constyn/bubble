package specials.buffs 
{import model.EntityVO;
	/**
	 * @author taires
	 */
	public class SlowBuff extends ABuff 
	{		
		public function SlowBuff(ent:EntityVO, amount:Number) 
		{
			super(ent, amount);
		}
		
		override protected function addEffect():void
		{
			enetity.barLoadingEffect = .7;
		}
		
		override protected function removeffect():void
		{
			enetity.barLoadingEffect = 1;
		}
	}
}
