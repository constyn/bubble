package view
{
	import components.background.Background;
	import config.Config;
	import events.ViewEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextFormatAlign;
	import utils.TextUtil;
	import flash.text.TextField;
	import components.Badge;
	import components.Enemy;
	import components.SimetricShape;
	import flash.display.Sprite;
	import flash.events.Event;
	import model.Model;
	import utils.GameButton;	
	
	
	public class ControlsView extends View
	{		
	    
		private var _model:Model;
		private var goBackBtn:GameButton;
		private var back:Background;
		private var controls:Sprite;
		
		private var theText:String = "Move around using <font color='#ccff00'>arrow keys</font> or <font color='#ccff00'>W,A,S,D</font>." +
									      "\nPress <font color='#ccff00'>Space</font> or <font color='#ccff00'>left click</font> for time warp." ;
		
		private var controlsText:TextField;
		

		public function ControlsView(model:Model):void 
		{	
			_model = model;
			addEventListener(Event.ADDED_TO_STAGE, init);	
		}
		
		private function init(event:Event):void 
		{	
		    removeEventListener(Event.ADDED_TO_STAGE, init);	
		    
		    back = new Background();
			addChild(back);
		    
		    goBackBtn = new GameButton("Go Back", goBack);	
		    goBackBtn.x = (Config.WIDTH  - goBackBtn.width) / 2;
		    goBackBtn.y = Config.HEIGHT - goBackBtn.height - 10;
		    addChild(goBackBtn);	
			
			controlsText = TextUtil.createText({size:30, bold:true, align:TextFormatAlign.CENTER});
			addChild(controlsText)
			controlsText.htmlText = theText;
			controlsText.x = (Config.WIDTH - controlsText.width) / 2;
			controlsText.y = (Config.HEIGHT - controlsText.height) / 2;
		}
		
		private function goBack():void
		{ 
			dispatchEvent(new ViewEvent(ViewEvent.CHANGE_VIEW, {view:Constants.STARTUP_VIEW}, true))
		}
		
		override public function destroy():void
		{
			
		}
	}	
}
