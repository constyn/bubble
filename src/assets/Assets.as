package assets
{
	public class Assets
	{				
		[Embed(source="../assets/fonts/ARLRDBD.TTF", 
				fontName = "Fago", 
				mimeType = "application/x-font", 
				fontWeight="normal", 
				fontStyle="normal", 
				advancedAntiAliasing="true")]
		private var Fago:Class;
		
		[Embed (source = "../assets/explosion.mp3")]
		public static var Explosion:Class;				
		
		[Embed (source = "../assets/level.mp3")]
		public static var LevelSound:Class;	
		
		[Embed (source = "../assets/pow.mp3")]
		public static var PickUp:Class;	
		
	    [Embed (source = "../assets/jump.mp3")]
		public static var Pop:Class;
		
		[Embed (source = "../assets/load.mp3")]
		public static var Load:Class;
		
		[Embed (source = "../assets/music.mp3")]
		public static var Music:Class;
		
		[Embed (source = "../assets/battle.mp3")]
		public static var Battle:Class;
		
		[Embed (source = "../assets/laser.mp3")]
		public static var Laser:Class;
		
		[Embed (source = "../assets/freeze.mp3")]
		public static var Freeze:Class;
	}
}
