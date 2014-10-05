package managers
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary; 
	
	public class SoundManager
	{		
		private var sounds:Dictionary;
		private var volumes:Dictionary;
		private var channels:Dictionary;
		
		public var oneAtATime:Array;
		
		private var channel:SoundChannel = new SoundChannel();
				
		public function SoundManager()
		{
		    oneAtATime = [];
		    
		    channels = new Dictionary();
		    volumes = new Dictionary();
		}
		
		public function loadSounds(sounds:Dictionary, volumes:Dictionary):void
		{
			this.sounds = sounds;	
			this.volumes = volumes;
		}
				
		public function playSound(sound:String, volume:Number = -1, offset:int = 0, repeatCount:int = 1):void
		{
		    
		    if(oneAtATime.indexOf(sound) != -1 && channels[sound])
		    {
		        return;
		    }
            else
            {
		        channels[sound] = sounds[sound].play(offset, repeatCount);
		        channels[sound].addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
		        
		        if(volumes[sound] != null) 
		            channels[sound].soundTransform = new SoundTransform(volumes[sound], 0);
		    }			    
		}			
		
		
		public function stopSound(sound:String):void
		{
		    if(channels[sound])
		    {
		        channels[sound].soundTransform = new SoundTransform(0, 0);            
		        channels[sound].stop();	
		        channels[sound] = null;			
		    }
		}
		
		protected function soundCompleteHandler(e:Event):void
		{
			for(var i:Object in channels)
				if(e.target == channels[i]) 
				{ 
				    channels[i] = null; 
			    }
		}			
	}
}
