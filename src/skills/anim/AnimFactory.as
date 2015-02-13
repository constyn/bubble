package skills.anim {
	import skills.Debuff;
	import skills.NormalAttack
	import skills.Concentrate;
	import skills.Cold;
	import skills.Power;
	import skills.Laser;
	import skills.Heal;
	import skills.Drain;
	import flash.display.Sprite;
	import skills.NormalAttack;
	/**
	 * @author taires
	 */
	public class AnimFactory 
	{		
		public static function getAnimation(skill:NormalAttack, start:Sprite, end:Sprite):Animation
		{
			if(skill is Drain)
				return new DrainAttackAnim(start, end);
			if(skill is Heal)
				return new HealAnim(start, end);
			if(skill is Laser)
				return new LaserAttackAnim(start, end);
			if(skill is Power)
				return new PowerAttackAnim(start, end);
			if(skill is Cold)
				return new ColdAttackAnim(start, end);
			if(skill is Concentrate)
				return new ConcentrateAnim(start, end);
			if(skill is Debuff)
				return new DebuffAnim(start, end);
			else
				return new BasicAttackAnim(start, end);
		}
	}
}
