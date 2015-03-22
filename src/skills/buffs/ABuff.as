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
		
		public function ABuff(amount:Number)
		{
			this.amount = amount
			repeatCount = 0;
			counter = 0;
		}
		
		public function applyBuff(ent:EntityVO):void
		{
			
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
				done = true;
			}
		}
	}
}
