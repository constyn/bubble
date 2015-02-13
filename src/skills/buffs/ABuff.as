package skills.buffs {
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class ABuff 
	{
		protected var ticks:int = 50;				
		protected var repeatCount:int;
		
		public var done:Boolean;		

		protected var counter:int;		
		protected var enetity:EntityVO;
		protected var amount:Number
		
		public function ABuff(ent:EntityVO, amount:Number)
		{
			enetity = ent;
			this.amount = amount
			addEffect();
		}
		
		public function update():void
		{
			if(done) return;
			
			if(repeatCount < ticks)
			{		
				counter++	
				if(counter == 30)
				{
					counter = 0;
					repeatCount++;
				}
			}
			else
			{
				removeffect();
				done = true;
			}
		}
		
		protected function addEffect():void
		{
			
		}
		
		protected function removeffect():void
		{
			
		}
	}
}
