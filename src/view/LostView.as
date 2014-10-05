package view
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenMax;
	import components.Anim;
	import components.Background;
	import components.Lander;
	import components.Platform;
	import config.Config;
	import events.ViewEvent;
	import flash.filters.BlurFilter;
	import utils.TextUtil;
	import flash.display.Sprite;
	import flash.events.Event;
	import model.Model;
	import com.greensock.TweenLite;
	import utils.GameButton;	
	
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign
	
	import events.GameEvent;
	
	public class LostView extends View
	{		
	    
		private var _model:Model;
		private var startScreenBtn:GameButton;
		private var finalLabel:TextField;
		private var back:Background;
		private var lander:Lander;
		private var platform:Platform;
		private var anim:Anim;
		private var hasWon:Boolean;
		private var fantoms:Array;
		
		public function LostView(theModel:Model):void 
		{	 
			_model = theModel
			addEventListener(Event.ADDED_TO_STAGE, init);	
		}
		
		private function init(event:Event):void 
		{	
			if(!back)
				back = new Background();
			addChild(back);
		    
			if(!startScreenBtn)
				startScreenBtn = new GameButton("Main Menu", gotoMainMenu);	
		    startScreenBtn.x = (width - startScreenBtn.width) / 2;
		    startScreenBtn.y = height - startScreenBtn.height - 10;
		    addChild(startScreenBtn);
		    
			if(!finalLabel)
				finalLabel = TextUtil.createText({color:Config.C6, size:30, bold:true})
			addChild(finalLabel);			
			
			showText();
		}
		
		private function gotoMainMenu():void
		{
		    dispatchEvent(new ViewEvent(ViewEvent.CHANGE_VIEW, {view:Constants.STARTUP_VIEW}, true));		   
		}
		
		override public function preSetup(...params):void
		{
			hasWon = params[0][0];
		}
		
		public function showText():void
		{
			fantoms = [];
			addEventListener(Event.ENTER_FRAME, createFantomLanders);	
			
			if(_model.points < 300)
				finalLabel.htmlText = "Your final score was <font color='#ff00cc'>" + _model.points + "</font> ... c'mon!\nI know you can do better than that!";
			else
				finalLabel.htmlText = "Game Over!\nYour score was <font color='#ff00cc'>"+ _model.points +"</font>.\nWant to give it another try?";
			
			finalLabel.x = (width - finalLabel.width) /2;	
		    finalLabel.y = (height - startScreenBtn.height - finalLabel.height - 10) / 2;	
		}
		
		private function createFantomLanders(event:Event):void 
		{	
			if (fantoms.length < 7 && Math.random() < 0.01)
			{
				var lander:Lander = new Lander()
				back.addChild(lander)					
				lander.x = Config.WIDTH * Math.random();
				lander.y = Config.HEIGHT + lander.height;	
				lander.changeEyes(7)	
				fantoms.push(lander);
				TweenMax.to(lander, 0, { tint:0xffffff } )
				lander.alpha = .1;
			}				
			
			for each(var fantom:Lander in fantoms)
			{
				fantom.y -= .5;
				if (fantom.y < -fantom.height-20)
				{
					fantom.x = Config.WIDTH * Math.random();
					fantom.y = Config.HEIGHT + fantom.height;
				}			
			}
		}
		
		override public function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, createFantomLanders);	
			
			for each(var fantom:Lander in fantoms)
				if (fantom && back.contains(fantom))
					back.removeChild(fantom);
		}
	}	
}
