package specials 
{
	import config.Config;
	import model.SpecialVO;
	import model.EntityVO;
	import model.WeaponVO;
	/**
	 * @author taires
	 */
	public class BaseSpecial 
	{
		public var specialVO:SpecialVO;
		public var specialAmountColor:uint = Config.C5;
		
		public function BaseSpecial(level:int, tier:int)
		{
			
		}
		
		public function applySpecial(e1:EntityVO, e2:EntityVO, weaponVO:WeaponVO):void
		{
			e1.currentHealth = Math.round(Math.min(e1.totalHealth, Math.max(0, e1.currentHealth)))
			e2.currentHealth = Math.round(Math.min(e2.totalHealth, Math.max(0, e2.currentHealth)))
			
			trace(e1.currentHealth, e2 .currentHealth)
		}
		
		public function toString():String
		{
			return "";
		}
	}
}
