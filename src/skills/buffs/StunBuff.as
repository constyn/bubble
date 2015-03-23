package skills.buffs 
{
	import model.EntityVO;
	/**
	 * ...
	 * @author taires
	 */
	public class StunBuff extends ABuff implements IBadBuff
	{		
		public function StunBuff(e:EntityVO, amount:Number) 
		{
			super(e, amount);	
		}		
	}
}