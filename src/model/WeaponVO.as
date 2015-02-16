package model
{  
	import skills.NormalAttack;
	public class WeaponVO 
	{	    
        public var skill:NormalAttack;
        public var tier:int = 1;
		public var coolDown:int;
        public var name:String;
		public var damage:Number;
		public var enabled:Boolean;
	}		
}
