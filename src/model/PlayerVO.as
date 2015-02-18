package model
{  
	import flash.geom.Point;
	public class PlayerVO extends EntityVO
	{	     
        public var acc:Number;
        public var decc:Number;
	    public var terminalV:Number;
	    public var speed:Number;
	    public var xp:Number = 10000;
		public var nextXPStep:Number = 100;
		public var pos:Point;
	}		
}
