package model
{  
	public class EntityVO 
	{	 
	    public var currentHealth:Number;   
		public var totalHealth:Number;
        public var cellArray:Array;
        public var dead:Boolean;
	    public var weapons:Array = [];
	    public var burning:Number;
	    public var level:int;
	    public var fightBarLoaded:Number = 0;
		public var barLoadingSpeed:Number = 0.25;
		public var barLoadingEffect:Number = 1;
		public var actions:Array;
		public var fitness:Number;
		public var weakEffect:Number = 1;
		public var attackEffect:Number = 1;
		public var buffs:Array = [];
	}		
}
