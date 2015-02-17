package
{	
	import assets.Assets;
	import events.SoundEvent;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	import managers.SoundManager;
	import model.GameModel;
	public class Sounds
	{		
		private var soundManager:SoundManager;			
		private var _model:GameModel;
		
		public function Sounds(theModel:GameModel)
		{
			_model = theModel;
			soundManager = new SoundManager();
		    initSounds();
		}
		
		private function initSounds():void
		{		
			var sounds:Dictionary = new Dictionary();
			sounds["explosion"] =  new Assets.Explosion() as Sound;
			sounds["level"] =  new Assets.LevelSound() as Sound;
			sounds["pickUp"] =  new Assets.PickUp() as Sound;
			sounds["load"] =  new Assets.Load() as Sound;
			sounds["pop"] =  new Assets.Pop() as Sound;
			sounds["music"] =  new Assets.Music() as Sound;
			sounds["battle"] =  new Assets.Battle() as Sound;
			sounds["laser"] =  new Assets.Laser() as Sound;		
			sounds["freeze"] =  new Assets.Freeze() as Sound;		
			
			var volumes:Dictionary = new Dictionary();
			volumes["explosion"] = .1;
            volumes["level"] =  .5;
            volumes["pickUp"] = .1;
            volumes["load"] =  .1;
			volumes["music"] = .1;
			volumes["battle"] = .1;
			volumes["laser"] =  .1;
			volumes["freeze"] = .05;
			volumes["pop"] = .1;
		
			soundManager.loadSounds(sounds, volumes);
			soundManager.oneAtATime = ["explosion", "move",  "music", "level", "pickUp"];
		}
		
		public function playSound(e:SoundEvent):void
		{	
			if(e.dataObj.sound == "music")
			{
				if(!_model.musicOn)
					return;
			}
			else if(!_model.soundOn)
			{
				return;
			}
				
			soundManager.playSound(e.dataObj.sound, -1, e.dataObj.offset, e.dataObj.repeat);
		}	
		
		public function stopSound(e:SoundEvent):void
		{
			soundManager.stopSound(e.dataObj.sound);
		}
		
	}
}
