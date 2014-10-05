package specials.anim 
{
	import specials.Debuff;
	import specials.Concentrate;
	import specials.Cold;
	import specials.Power;
	import specials.Laser;
	import specials.Heal;
	import specials.Drain;
	import flash.display.Sprite;
	import specials.BaseSpecial;
	/**
	 * @author taires
	 */
	public class AnimFactory 
	{		
		public static function getAnimation(special:BaseSpecial, start:Sprite, end:Sprite):Animation
		{
			if(special is Drain)
				return new DrainAttackAnim(start, end);
			if(special is Heal)
				return new HealAnim(start, end);
			if(special is Laser)
				return new LaserAttackAnim(start, end);
			if(special is Power)
				return new PowerAttackAnim(start, end);
			if(special is Cold)
				return new ColdAttackAnim(start, end);
			if(special is Concentrate)
				return new ConcentrateAnim(start, end);
			if(special is Debuff)
				return new DebuffAnim(start, end);
			else
				return new BasicAttackAnim(start, end);
		}
	}
}
