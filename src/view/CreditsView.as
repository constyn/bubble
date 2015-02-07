package view
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenMax;
	import components.background.Background;
	import components.Lander;
	import config.Config;
	import events.ViewEvent;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import utils.TextUtil;
	import flash.text.TextField;
	import components.Badge;
	import components.Enemy;
	import components.SimetricShape;
	import flash.display.Sprite;
	import flash.events.Event;
	import model.Model;
	import utils.GameButton;	
	
	
	public class CreditsView extends View
	{			    
		private var _model:Model;
		private var goBackBtn:GameButton;
		private var back:Sprite;
		private var controls:Sprite;		
		private var wonTexts:Array = [ "This is it!",
									"Nothing more you can do now.",
									"You just finished the game.",
									"You did a pretty good job.",
									"Only died about <font color='#ff00cc'>%1</font> times.",
									"Your final score was <font color='#ff00cc'>%2</font>.",
									"Well you better stop playing games.",
									"And do something meaningful with your life.",
									"Just kidding...LOL",
									"Have a great day!",
									"This game was made by Taires."]
									
		private var simpleCredits:Array = [ "This game was made by Taires.",
											"Enjoy it!"]
									
		private var playingTexts:Array;
		private var isEndingCredits:Boolean;
		private var lander:Lander;
		
		public function CreditsView(model:Model):void 
		{	
			_model = model;
			addEventListener(Event.ADDED_TO_STAGE, init);	
		}
		
		private function init(event:Event):void 
		{		    
			if(!back)
				back = new Sprite();			
			back.graphics.clear();	
			back.graphics.beginFill(0x000000, 1)
			back.graphics.drawRect(0, 0, Config.WIDTH,	Config.HEIGHT)
			addChild(back)	
		    
			if(!goBackBtn)
				goBackBtn = new GameButton("Go Back", goBack);				
		    goBackBtn.x = (Config.WIDTH  - goBackBtn.width) / 2;
		    goBackBtn.y = Config.HEIGHT - goBackBtn.height - 10;
		    addChild(goBackBtn);	
			
			if (!lander)
				lander = new Lander();
				
			lander.alpha = 0;
			
			playCredits();
		}
		
		private function goBack():void
		{ 
			dispatchEvent(new ViewEvent(ViewEvent.CHANGE_VIEW, {view:Constants.STARTUP_VIEW}, true))
		}
		
		override public function preSetup(...params):void
		{
			isEndingCredits = params[0][0];
		}
		
		private function playCredits():void
		{
			var texts:Array = isEndingCredits? wonTexts:simpleCredits;
			playingTexts = [];
			var moveTime:int = 20;
			var delayMulti:int = 3;
			for(var i:int = 0; i < texts.length; i++)
			{
				var txt:TextField = TextUtil.createText({color:Config.C4, size:20});
				addChild(txt);
				
				var pattern1:RegExp = /%1/;  	
				texts[i] = String(texts[i]).replace(pattern1, _model.landerTotalDeaths);
				
				var pattern2:RegExp = /%2/;  	
				texts[i] = String(texts[i]).replace(pattern2, _model.points);
				
				txt.htmlText = texts[i];				
				txt.x = (Config.WIDTH - txt.width) / 2;
				txt.y = Config.HEIGHT * 2 / 3;
				txt.filters = [new BlurFilter(0,0,0)]
				txt.alpha = 0;
				TweenMax.to(txt, .5, {delay:i * delayMulti, alpha:1 } )
				TweenMax.to(txt, moveTime, {delay:i * delayMulti, y:20, ease:Linear.easeNone, onComplete:(i == texts.length - 1? showLander:new Function())} )
				TweenMax.to(txt, .5, {delay:i*delayMulti+moveTime-3, alpha:0})	
				playingTexts.push(txt);
			}
		}
		
		private function showLander():void
		{
			addChild(lander);
			lander.scaleX = 10;
			lander.scaleY = 10;
			lander.x = 80;
			lander.y = (Config.HEIGHT - lander.height) / 2
			TweenMax.to(lander, 3, {alpha:.2})
		}
		
		override public function destroy():void
		{
			for each(var txt:TextField in playingTexts)
			{
				TweenMax.killTweensOf(txt)
				if (txt && contains(txt))
					removeChild(txt)
			}
			
			if (back && contains(back))
				removeChild(back);
			
			playingTexts = [];
		}
	}	
}
