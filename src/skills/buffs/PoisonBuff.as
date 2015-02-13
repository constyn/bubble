package skills.buffs {
	import model.EntityVO;

	/**
	 * @author taires
	 */
	public class PoisonBuff extends ABuff
	{
		private var healthPerTick:int;
		
		public function PoisonBuff(amount:Number) 
		{
			super(amount);			
		}
		
		override public function update():void
		{
			if(done) return;
			
			if(repeatCount < ticks)
			{		
				counter++	
				if(counter == 100)
				{
					counter = 0;
					repeatCount++;
					enetity.currentHealth -= healthPerTick;
				}
			}
			else
			{
				removeffect();
				done = true;
			}
		}
		
		override protected function addEffect():void
		{
			healthPerTick = amount;
		}
		
		override protected function removeffect():void
		{
			healthPerTick = 0;
		}
	}
}
