package model
{  
	import skills.BaseAttack;
	public class WeaponVO 
	{	    
        public var attack:Number = 1;
        public var freeze:Number;
        public var repeat:Number = 1;
        public var skill:BaseAttack;
        public var tier:int = 1;
		public var coolDown:int;
        public var name:String;
	}		
}
