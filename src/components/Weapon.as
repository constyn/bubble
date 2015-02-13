package components
{
	import components.ui.ToolTip;
	import utils.Draw;
	import utils.TextUtil;
	import flash.events.Event;
	import skills.NormalAttack;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.text.*;
	import com.greensock.TweenMax;
	import config.Config;
	import model.WeaponVO;
	
	public class Weapon extends Sprite 
	{		
	    private var _weaponVO:WeaponVO;
	     
	    private const colors:Array =[[0xFFFFFF, Config.C1, Config.C3],
	                                 [0xFFFFFF, Config.C5, Config.C2], 
	                                 [0xFFFFFF, Config.C3, Config.C5]]
		
		private var states:Array = [[0,0,0,0,4,4],
                                    [0,0,4,4,4,4],
                                    [0,4,4,4,4,4],
                                    [0,4,4,4,4,4],
                                    [4,4,4,4,4,4],
                                    [4,4,4,4,4,4],
                                    [4,4,4,4,4,4],
                                    [4,4,4,4,4,4],
                                    [0,4,4,4,4,4],
                                    [0,4,4,4,4,4],
                                    [0,0,4,4,4,4],
                                    [0,0,0,0,4,4]]
                       
		private var toolTipText:String;             
        private var toolTip:ToolTip;	
        private var coolDownText:TextField;
        private var _enabled:Boolean;
        private var selectSprite:Sprite;
        private var selected:Boolean;
        public var disabled:Boolean;
        public var animate:Boolean;
		public var selectedForAttack:Boolean;
        private var weaponGr:Sprite;
		
		public function Weapon(weaponVO:WeaponVO):void 
		{	
		    _weaponVO = weaponVO; 
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
		    removeEventListener(Event.ADDED_TO_STAGE, init);
			
			drawWeapon();
		    
		    buttonMode = true;
		    animate = true;
		    
			
			toolTipText =  "Attack: " +  TextUtil.setHTMLColor(String(_weaponVO.damage), Config.C2) + "\n";
			if(_weaponVO.skill)
			{			
				if(!_weaponVO.skill.skillVO.doesDamage)
					toolTipText = "";
			    toolTipText += _weaponVO.skill.toString();	
				
				var turnText:String = weaponVO.coolDown +  " turn" + (_weaponVO.coolDown == 1? "":"s");
				toolTipText += "\n" + "Cooldown: " + TextUtil.setHTMLColor(turnText, Config.C4) 							  
			}
			
			toolTipText = TextUtil.setHTMLColor(_weaponVO.name, Config.C1) + "\n"+ toolTipText;
			toolTip = new ToolTip(toolTipText);	
			
		    createText();	
		}
		
		private function createText():void
		{
		    var tf:TextFormat = new TextFormat("Verdana", 40, 0xCCCCCC); 
		    tf.align = TextFormatAlign.CENTER;
		    
		    coolDownText = new TextField();
		    coolDownText.width = 50;
		    coolDownText.mouseEnabled = false;
			coolDownText.selectable = false;
			coolDownText.defaultTextFormat = tf;
			coolDownText.autoSize = TextFieldAutoSize.CENTER;			
			coolDownText.multiline = true;
			coolDownText.wordWrap = true;
			coolDownText.visible = false;
			addChild(coolDownText)			
			
		}
		
		public function setupListeners(action:String="addEventListener"):void
		{
		    this[action](MouseEvent.ROLL_OVER, enlarge)
		    this[action](MouseEvent.ROLL_OUT, shrink)
		}
		
		private function enlarge(event:MouseEvent):void
		{
		    if(animate && _enabled)
		        TweenMax.to(weaponGr, .3, {scaleX:1.03, scaleY:1.03, x:-2, y:-2})	
			addChild(toolTip);
		}
		
		private function shrink(event:MouseEvent):void
		{
		    if(animate)
		        TweenMax.to(weaponGr, .2, {scaleX:1, scaleY:1, x:0, y:0})
		    if(toolTip && contains(toolTip) &&  !selected)
		        removeChild(toolTip)
		}
		
		private function drawWeapon():void
		{
			weaponGr = new Sprite();
			addChild(weaponGr);
			
		    var dim:int = Config.WORLD_SCALE - 1;
		    
		    weaponGr.graphics.clear();
			
			Draw.drawRoundRect(weaponGr, 0, 0, 50, 50, 5, colors[_weaponVO.tier][1], .8)
			Draw.drawRoundRect(weaponGr, 5, 5, 40, 40, 4, 0x000000, .8)
			    
	        for(var i:int = 0; i < states.length; i++)
	        {
	            for(var j:int = 0; j < states[i].length; j++)
	            {
	                if(states[i][j] == 4)
	                    states[i][j] = int(Math.random() * 3)
	                    
	                weaponGr.graphics.beginFill(colors[_weaponVO.tier][states[i][j] - 1], 1)
	                weaponGr.graphics.drawCircle(j*dim + 9, i*dim + 9, 1);
		            weaponGr.graphics.drawCircle((states[i].length * 2 - j - 1)*dim + 9, i * dim + 9, 1);	
		            weaponGr.graphics.endFill();	                    
                }
		    }
		}	
		
		public function disable():void
		{
		    weaponGr.alpha = .5
		    disabled = true
		    buttonMode = false;
		    _enabled = false;
		}
		
		public function enable():void
		{
		    weaponGr.alpha = 1
		    disabled = false;
		    buttonMode = true;
		    _enabled = true;
		}
		
		public function get enabled():Boolean
		{
		    return _enabled;
		}
		
		public function update(loaded:Number):void
		{	
		    if(_weaponVO.coolDown > 0)
		    {
		        weaponGr.alpha = .5;
		        coolDownText.visible = true;		        
		        coolDownText.text = String(_weaponVO.coolDown)
		    }		        
		    else
		    {
		        weaponGr.alpha = 1;
		        coolDownText.visible = false;
		    }  
		    
		    if(loaded < (_weaponVO.tier + 1) * 33)
		        disable();
		    else
		        enable();	   
		}	
		
		public function get weaponVO():WeaponVO
		{
		    return _weaponVO;
		}
		
		public function select():void
		{
		    if(!selectSprite)
		        selectSprite = new Sprite();
		    selectSprite.graphics.clear();
			Draw.drawRoundRect(selectSprite, 0, 0, 50, 50, 5, 0xffffff, .3)
			addChild(selectSprite)
			selectSprite.x = 0;
			selectSprite.y = 0;
			selected = true;
		}
		
		public function deselect():void
		{
		    if(selectSprite && contains(selectSprite))
		        removeChild(selectSprite)
		    if(toolTip && contains(toolTip))
		        removeChild(toolTip)
		    selected = false;
		}
		
		public function cleanUp():void
		{
			_weaponVO.coolDown = 0;
			coolDownText.visible = false
		}
		
		public function selectForAttack():void
		{			
			TweenMax.to(weaponGr, .2, {y:-20})
			selectedForAttack = true;
		}
		
		public function deselectForAttack():void
		{
			TweenMax.to(weaponGr, .2, {delay:.2, y:0})
			selectedForAttack = false
		}
	}	
}
