package utils 
{
	/**
	 * ...
	 * @author 
	 */
	public class NumUtil 
	{
		
		public function NumUtil() 
		{
			
		}
		
		public static function range(from:Number, to:Number):Number
		{
			return Math.random() * to + from;
		}
		
		public static function getCorrectedValue(max:Number, current:Number):int 
		{
			return Math.round(Math.min(max, Math.max(0, current)));
		}
		
	}

}