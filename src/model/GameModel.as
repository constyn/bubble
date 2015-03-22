package model
{  
    import flash.utils.Dictionary;
    
	public class GameModel 
	{
	    public var points:Number
	    public var player:PlayerVO;        
	    public var currentLevel:Number;
	    public var nutrients:Array;
	    public var enemies:Array;
	    public var toxins:Array;
	    public var flashvars:Dictionary;
	    public var battleMode:Boolean;
	    
		public var musicOn:Boolean;
		public var soundOn:Boolean;
		
	    private var initObj:Object;   
	
	    public function GameModel(obj:Object = null):void
	    {
	        initObj = obj;
	        initModel();
	    }		
		
		public function initModel():void
	    {
	        if(initObj == null)
	        {
	            player = new PlayerVO();
	            player.speed = 0;
	            player.dead = false;
	            player.totalHealth = 0;
	            player.acc = .1;
	            player.decc = .95;
	            player.terminalV = 3;
	            player.level = 1;
	            player.buffs = [];
	            player.cellArray = []; 	 
	            	            
	            nutrients = [];     
	            enemies = []; 
	            
	            battleMode = false;
	            points = 0;
				
				musicOn = true;
	            soundOn = true;
			}	
	    } 			
	}		
}
