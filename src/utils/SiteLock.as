package utils
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author RTLShadow
	 */
	public class SiteLock extends Sprite
	{
		public var _url:String;
		
		private var _lTesting:Boolean;
		private var _sArray:Array;
		
		private var sRef:Stage;
		
		/**
		 * @param	localTesting Whether or not you want to allow local testing.
		 */
		public function SiteLock(stageRef:Stage , localTesting:Boolean, siteArray:Array)
		{
			sRef = stageRef;
			_lTesting = localTesting;
			_sArray = siteArray;
			_url = sRef.loaderInfo.url;
		}
				
		public function get allowedSite():Boolean
		{
			var a:Boolean;
			if (_url.search("file://") != -1)
			{ // If the URL is local
				if (_lTesting)
				{ // If local testing is allowed
					a = true;
				}
				else
				{
					a = false;
				}
			}
			var i:int = 0;
			while (i < _sArray.length && !a)
			{
			    if (_url.indexOf(_sArray[i]) != -1)
				{
					a = true;
				}
				i++;
			}
			return a;
		}
		
		public function get isLocal():Boolean
		{
			var local:Boolean;
			if (_url.search("file://") != -1)
			{
				local = true;
			}else {
				local = false;
			}
			return local;
		}
	}
}
