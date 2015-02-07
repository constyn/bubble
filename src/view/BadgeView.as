package view
{
	import components.background.Background;
	import events.ViewEvent;
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
	
	
	public class BadgeView extends View
	{		
	    
		private var _model:Model;
		private var goBackBtn:GameButton;
		private var back:Background;
		
		private var badgeArr:Array;
		private var badgeSeeds:Array = [1757,2333,6511,7319,2289,4036]
		private var colors:Array = [[0xFFFFFF, Config.C4],
									[Config.C1, Config.C4],
									[Config.C6, Config.C2],
									[0xFFFFFF, Config.C1],
									[Config.C2, Config.C3],
									[0xFFFFFF, Config.C6]]
		private var badgeNames:Array = ["Ecofriendly",
										"Greed",
										"Kamikaze",
										"Banker",
										"Loverboy",									
										"Survivor"
									   ]
		private var badgeTexts:Array = ["Finish 10 different rounds \nwith your fuel on green",
										"Collect all coins from \nround 21 without dying",
										"Kill all enemies by suicide \nin round 13",										
										"Collect all the coins",
										"Collect all the hearts",
										"Finish the game without \ndying"
									   ]
		
		public function BadgeView(model:Model):void 
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
		    goBackBtn.x = (width - goBackBtn.width) / 2;
		    goBackBtn.y = height - goBackBtn.height - 10;
		    addChild(goBackBtn);	
			
			showBadges();
		}
		
		private function goBack():void
		{ 
			dispatchEvent(new ViewEvent(ViewEvent.CHANGE_VIEW, {view:Constants.STARTUP_VIEW}, true))
		}
		
		public function showBadges():void
		{
			visible = true;
			
			if(!badgeArr)
			{
				badgeArr = [];
				for(var i:int = 0; i < badgeSeeds.length; i++)
				{
					//badgeSeeds[i] = int(Math.random() * 10000)
					badgeArr.push(createBadge(badgeSeeds[i], badgeNames[i], badgeTexts[i], colors[i]))
					addChild(badgeArr[i])
					badgeArr[i].x = i%2 * (badgeArr[i].width + 40) + 80;
		        	badgeArr[i].y = int(i/2) * (badgeArr[i].height + 30) + 80;
					if(_model.unlockedBadges[i])
					{
						badgeArr[i].alpha = 1
						badgeArr[i].filters = [new GlowFilter(Config.C4)]
					}	
					else
					{
						badgeArr[i].alpha = .6;				
					}
				}
			}
			else
			{
				for(i = 0; i < badgeArr.length; i++)
				{
					if(_model.unlockedBadges[i])
					{
						badgeArr[i].alpha = 1
						badgeArr[i].filters = [new GlowFilter(Config.C4)]
					}	
					else
					{
						badgeArr[i].alpha = .6;				
					}
				}
			}
		}
		
		private function createBadge(seed:Number, name:String, descr:String, colors:Array):Sprite
		{
			var badgeCont:Sprite = new Sprite();
			addChild(badgeCont);
			badgeCont.graphics.beginFill(0x000000, .8)
			badgeCont.graphics.drawRoundRect(0,0, 220, 60, 5, 5)
			badgeCont.graphics.beginFill(0x222222, .8)
			badgeCont.graphics.drawRoundRect(1,1, 48, 58, 2, 2)
			badgeCont.graphics.beginFill(0x111111, .8)
			badgeCont.graphics.drawRoundRect(49,1,171, 23, 2, 2)
			badgeCont.graphics.endFill();
			
			var badge:Badge = new Badge(seed, colors);
			badgeCont.addChild(badge)
			badge.x = 6;
			badge.y = 13;
			
			var nameText:TextField = TextUtil.createText({size:13, color:Config.C1, bold:true})
			nameText.text = name;
			badgeCont.addChild(nameText)
			nameText.x = badge.x + badge.width + 8
			nameText.y = 3
			
			var descrText:TextField = TextUtil.createText({color:Config.C4})
			descrText.text = descr;
			badgeCont.addChild(descrText)
			descrText.x = nameText.x;
			descrText.y = nameText.y + nameText.height + 2;			
			
			return badgeCont;
		}
		
	}	
}
