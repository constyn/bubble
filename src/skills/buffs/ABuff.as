package skills.buffs {
	import model.EntityVO;
	/**
	 * @author taires
	 */
	public class ABuff 
	{
		protected var ticks:int = 10;				
		protected var repeatCount:int;
		
		public var done:Boolean;		

		protected var counter:int;		
		protected var amount:Number
		protected var ent:EntityVO
		
		public function ABuff(e:EntityVO, amount:Number)
		{
			this.amount = amount
			ent = e;
			repeatCount = 0;
			counter = 0;
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
					onTick();
				}
			}
			else
			{
				done = true;
			}
		}
		
		public function applyBuff():void
		{
			
		}
		
		public function onTick():void
		{
			
		}
	}
}
