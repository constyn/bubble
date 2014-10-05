package events {
	import flash.events.Event;
	/**
	 * @author taires
	 */
	public class MessageEvent extends Event
	{
		static public const MESSAGE:String = "message";		
		public var msg:String;
		
		public function MessageEvent(type:String, msg:String = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);			
			this.msg = msg;
		}
	}
}
