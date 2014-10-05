package genetic 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Node 
	{
		public var value:String
		public var left:Node;
		public var right:Node;
		public var leftAction:Node;
		public var rightAction:Node;
		
		public function Node(value:String, left:Node = null, right:Node = null, leftAction:Node = null, rightAction:Node = null) 
		{
			this.value = value;
			this.left = left;
			this.right = right;
			this.leftAction = leftAction;
			this.rightAction = rightAction;
		}
		
	}

}
