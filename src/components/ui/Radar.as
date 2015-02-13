package components.ui {
	import components.Player;
	import components.World;
	import config.Config;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * @author taires
	 */
	public class Radar extends Sprite
	{
		private const WIDTH:int = 100;
		private const HEIGHT:int = 100;
		private var world:World
		private var player:Player;
		private var radarImage:Bitmap;
		private var radarBmd:BitmapData;
		private var bitmapMask:Sprite
		private var angle:int = 0;
		
		public function Radar(world:World, player:Player)
		{
			this.world = world;	
			this.player = player;		
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
		    removeEventListener(Event.ADDED_TO_STAGE, init)
			radarBmd = new BitmapData(WIDTH,HEIGHT,true, 0x000000);
			radarImage = new Bitmap(radarBmd);
			addChild(radarImage)
			
			bitmapMask = new Sprite()
			bitmapMask.graphics.beginFill(0x000000, 1)
			bitmapMask.graphics.drawCircle(0, 0, HEIGHT/2)
			bitmapMask.x = HEIGHT / 2;
			bitmapMask.y = HEIGHT / 2;
			addChild(bitmapMask);
			radarImage.mask = bitmapMask;
		}
		
		public function update():void
		{
			radarBmd.draw(bitmapMask)
			radarBmd.fillRect(radarBmd.rect, 0x77000000)
			var pMatrix:Matrix = new Matrix();
			pMatrix.translate(600 - player.x, 500 - player.y)
		    //pMatrix.scale(.086, .098)	
			pMatrix.scale(.088, .095)		
            radarBmd.draw(world, pMatrix)
			pMatrix = new Matrix();
			pMatrix.rotate(player.rotation * Math.PI/180)
			pMatrix.translate(600, 500)		
		    pMatrix.scale(.086, .098)		
			radarBmd.draw(player, pMatrix)
		}
	}
}
