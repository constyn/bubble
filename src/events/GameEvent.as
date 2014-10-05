package events

{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{		
		static public const START_FIGHT:String = "startFight";	
		static public const START_NEW_GAME:String = "startNewGame";	
		static public const CONTINUE_GAME:String = "continueGame";	
		static public const END_FIGHT:String = "endFight";	
		static public const TURN_OVER:String = "turnOver";	
		static public const GO_TO_MAIN:String = "goToMain";		
		static public const START_GAME:String = "startGame";		
		static public const GAME_OVER:String = "gameOver";
		static public const DISPAWN:String = "dispawn";	
		static public const ANIM_OVER:String = "animOver";					
		static public const TRACK:String = "track";		
		
		public var dataObj:Object;
		
		public function GameEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			dataObj = data;
		}

	}
}
