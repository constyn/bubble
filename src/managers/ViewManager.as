package managers 
{
	import events.ViewEvent;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import view.Constants;
	import view.View;
	/**
	 * ...
	 * @author ...
	 */
	public class ViewManager extends Sprite
	{		
		private var currentView:View;
		private var views:Dictionary;
		
		public function ViewManager() 
		{
			views = new Dictionary();
		}
		
		public function changeView(...params):void
		{
			hideAll();			
			if (currentView && contains(currentView))
			{
				removeChild(currentView);
			}
			
			if (params[0] is String)
			{				
				currentView = views[params[0]]
			}
			else if (params[0] is ViewEvent)
			{				
				currentView = views[params[0].dataObj.view]
				
				if (params[0].dataObj.params)
					currentView.preSetup(params[0].dataObj.params)
			}				
			
			currentView.visible = true;			
			addChild(currentView)
			
			stage.focus = null;
		}
		
		public function setView(key:String, newView:View):void
		{
			views[key] = newView;
		}
		
		private function hideAll():void
		{
			for each(var aView:View in views)
			{
				if (currentView)
					currentView.destroy();
				aView.visible = false;
			}
		}
		
	}

}