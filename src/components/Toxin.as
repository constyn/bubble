package components
{
	import flash.display.Sprite;
	import flash.events.Event;
    import model.CellVO;   
	import com.greensock.TweenMax;
	
	public class Toxin extends Sprite 
	{		
		private var _cellVO:CellVO;			
		
		public function Cell(vo:CellVO):void 
		{	
		    _cellVO = vo;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void 
		{	
		    
		    TweenMax.to(this, 3, {delay:Math.random(), scaleX:.8, scaleY:.8, yoyo:true, repeat:-1})    
		}
		
	
	}
}
