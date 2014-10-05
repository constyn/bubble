package managers 
{
	import model.GameModel;
	import flash.events.EventDispatcher;
	/**
	 * @author taires
	 */
	public class StoryManager extends EventDispatcher
    {
		var _model:GameModel;
		
		public function StoryManager(model:GameModel)
		{
			_model = model;
		}
		
		public function update():void
		{
			
		}
	}
}
