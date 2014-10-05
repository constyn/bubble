package events

{
	import flash.events.Event;
	
	public class SoundEvent extends Event
	{		
		static public const PLAY_SOUND:String = "playSound";	
		static public const STOP_SOUND:String = "stopSound";	
		static public const BATTLE_MODE:String = "battleMode";
		static public const NORMAL_MODE:String = "normalMode";	
		
		public var dataObj:Object;
		
		public function SoundEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			dataObj = data;
		}

	}
}
