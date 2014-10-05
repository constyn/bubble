package events
{
	import flash.events.Event;
	
	public class ViewEvent extends Event
	{		
		static public const CHANGE_VIEW:String = "changeView";	
		
		public var dataObj:Object;
		
		public function ViewEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			dataObj = data;
		}

	}
}
