package genetic 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Roulette
	{
	    private var candidates:Array;
	    private var pinPos:Number;
	    private var fitnessArr:Array;
	    private var totalFitness:Number;
	    
	    public function Roulette()
	    {
	        pinPos = 0;
	        fitnessArr = [];
	    }
	    
	    public function getNextCandidate():Node
	    {
	        var ran:Number = Math.random() * totalFitness
	        ran = ran + pinPos > totalFitness? ran + pinPos - totalFitness:ran + pinPos;
	        pinPos = ran;
	        
	        var i:int = 0
	        var found:Boolean = false
	        while(i < fitnessArr.length && !found)
	        {
	            if(fitnessArr[i] > ran)
	                found = true;
	            else
	                i++;
	        }
	        return candidates[i].tree;
	    }
	    
	    public function setCandidates(value:Array):void
	    {
	        candidates = value;
	        fitnessArr = [];
	        totalFitness = 0;
	        for(var i:int = 0; i < value.length; i++)
	        {
	            if(value[i].fitness > 0)
	            {
	                totalFitness += value[i].fitness;
	                fitnessArr.push(totalFitness);
	            }
	        }
	        pinPos = 0;
	    }
	}
}
