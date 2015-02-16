package components.fight 
{
	import com.greensock.TweenMax;
	import components.cell.Body;
	import components.Weapon;
	import config.Config;
	import flash.display.Sprite;
	import flash.text.TextField;
	import model.EntityVO;
	import model.PlayerVO;
	import utils.Draw;
	import utils.TextUtil;
	/**
	 * ...
	 * @author 
	 */
	public class WeaponSection extends Sprite
	{
		private var entityVO:EntityVO;
		private var weapons:Array;
		private var life:Sprite;
		private var playerWeapons:Boolean;
		
		public function WeaponSection(vo:EntityVO) 
		{
			entityVO = vo;
			draw();
		}
		
		private function draw():void
		{			
			var contColor:uint = 0x00;			
			Draw.drawRoundRect(this, 0, 0, 530, 70, 5, Config.C1, 1)			
			Draw.drawRoundRect(this, 5, 5, 170, 60, 4, contColor, .5)			
			Draw.drawRoundRect(this, 180, 5, 170, 60, 4, contColor, .5)						
			Draw.drawRoundRect(this, 355, 5, 170, 60, 4, contColor, .5)
					    
			var counters:Array = [0,0,0];
		    for(var i:int = 0; i < entityVO.weapons.length; i++)
		    {	       
	            var weapon:Weapon = entityVO.weapons[i];
	            this.addChild(weapon);	
	            weapon.x = 10 + (55) * counters[weapon.weaponVO.tier] + weapon.weaponVO.tier * 175;
	            weapon.y = 10;
				counters[weapon.weaponVO.tier]++;				        
		    }	    
		}
		
		public function clear():void 
		{
			if(playerWeapons)
			for(var i:int = 0; i < weapons.length; i++)
		    {	
				
			}
		}	
		
	}
}