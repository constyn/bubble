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
	import skills.buffs.ABuff;
	import utils.Draw;
	import utils.TextUtil;
	/**
	 * ...
	 * @author 
	 */
	public class BuffsSection extends Sprite
	{
		private var entityVO:EntityVO;
		private var buffs:Array;
		
		public function BuffsSection(vo:EntityVO) 
		{
			entityVO = vo;
			draw();
		}
		
		private function draw():void
		{			
	    
		}
		
		public function update():void
		{
			for each(var buff:ABuff in  entityVO.buffs)
		    {	 
				if (buff.done && buffs.indexOf(buffs) != -1)
				{
					buffs.splice(buffs.indexOf(buffs), 1);
					
				}
			}
		}
		
		private function addBuff():void
		{
			
		}
		
		private function removeBuff():void
		{
			
		}
	}
}