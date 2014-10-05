package genetic
{
	import flash.display.Sprite;
	import model.EntityVO;
	/**
	 * ...
	 * @author ...
	 */
	public class Generator extends Sprite
	{	
		private var conditions:Array = ["<", ">", "=", "!"];
		private var operations:Array = ["/", "*", "-", "+"];
		private var actions:Array    = [];
		private var variables:Array  = ["special","elife", "mlife"];
		private var condVar:Array;		
		private var roulette:Roulette;
		
		public function Generator() 
		{		
			roulette = new Roulette();
		}
			
		public function generateActions(entity:EntityVO):Array
		{
			actions = ["none"];
			for(var i:int=0; i < entity.weapons.length; i++)
				for(var j:int = 0; j < entity.weapons[i].length; j++)
					actions.push("attack" + i + j)
			condVar = conditions.concat(variables.concat(operations));
			
			var moves:Array = [];
			for (i = 0; i < Math.random() * 10; i++)
			{
				var tree:Node = generateTree(conditions[int(Math.random() * conditions.length)]);
				moves.push(tree);
			}
			
			return moves;			
		}	
		
		private function mutateTree(node:Node):Node
		{
		    var nodes:Array = treeToString(node).split(".");
		    var ran:int = Math.random() * nodes.length;
		    
		    if (conditions.indexOf(nodes[ran]) != -1)
		    {
			    nodes[ran] = conditions[int(Math.random() * conditions.length)];
			}
			else if (operations.indexOf(nodes[ran]) != -1)
			{
			    nodes[ran] = operations[int(Math.random() * operations.length)];
			}
			else if (actions.indexOf(nodes[ran]) != -1)
			{
			    nodes[ran] = actions[int(Math.random() * actions.length)];	
			}
			else
			{
			    nodes[ran] = variables[int(Math.random() * variables.length)];	
			    if (nodes[ran] == "ran")
				    nodes[ran] = String(int(Math.random() * 100));			
			}	
		    var newNode:Node = stringToTree(nodes);
		    return newNode;
		}
				
		private function stringToTree(str:Array):Node
		{
		    var char:String = str.splice(0, 1);		        
		    if (conditions.indexOf(char) != -1)
			{
				return new Node(char, stringToTree(str), stringToTree(str),
								      stringToTree(str), stringToTree(str));		
			}
			else if (operations.indexOf(char) != -1)
			{
				if (char == "stake")
					return new Node(char, stringToTree(str));
				else
					return new Node(char, stringToTree(str), stringToTree(str));
			} 
			else
				return new Node(char);
		}
		
		private function treeToString(node:Node, br:Boolean = false):String	
		{
			if (node.left)
				return (br? "(":"") + node.value + "." + (node.left? treeToString(node.left, br):"") + (node.right? treeToString(node.right, br):"") + (node.leftAction? treeToString(node.leftAction, br):"") + (node.rightAction? treeToString(node.rightAction, br):"") + (br?")":"");		 
			else
				return node.value + ".";
		}
		
		private function combineTrees(cand1:Node, cand2:Node):Node
		{
		    var newNode:Node = stringToTree(treeToString(cand1).split("."));
		    var randNode:Node = getRandomNode(newNode)
		    randNode.left = stringToTree(treeToString(getRandomNode(cand2)).split("."));
		            
		    return newNode;
		}
		
		private function getRandomNode(node:Node):Node
		{
		    var arr:Array = getNodeArray(node);
		    var rand:int = int(Math.random() * arr.length)
		    while(!arr[rand].left)
		        rand = int(Math.random() * arr.length)
		        
		    return arr[rand];
		}
		
		private function getNodeArray(node:Node):Array
		{
		    if(!node)
		        return [];
		    if (node.left)
			    return [node].concat(getNodeArray(node.left)).concat(getNodeArray(node.right)).concat(getNodeArray(node.leftAction)).concat(getNodeArray(node.rightAction))
			else
				return [node];			   			
		}
		
		private function generateTree(str:String):Node
		{			                        
			if (conditions.indexOf(str) != -1)
			{
				return new Node(str, generateTree(condVar[int(condVar.length * Math.random())]), generateTree(condVar[int(condVar.length * Math.random())]),
								     generateTree(actions[int(actions.length * Math.random())]), generateTree(actions[int(actions.length * Math.random())]));		
			}
			else if (operations.indexOf(str) != -1)
			{
				if (str == "stake")
					return new Node(str, generateTree(condVar[int(condVar.length * Math.random())]))
				else
					return new Node(str, generateTree(condVar[int(condVar.length * Math.random())]), generateTree(condVar[int(condVar.length * Math.random())]));
			}
			else if (str == "ran")
				return new Node(String(int(Math.random() * 100)));			
			else
				return new Node(str);
		}
		
		private function evaluate(node:Node):String
		{
			if (conditions.indexOf(node.value) != -1)
			{
				if (node.value == ">")
				{					
					if(parseFloat(evaluate(node.left)) > parseFloat(evaluate(node.right)))
						return evaluate(node.leftAction);
					else 
						return evaluate(node.rightAction);
				}
				else if (node.value == "<")
				{
					if(parseFloat(evaluate(node.left)) < parseFloat(evaluate(node.right)))
						return evaluate(node.leftAction);
					else 
						return evaluate(node.rightAction);
				}
				else if (node.value == "!") 
				{
					if(parseFloat(evaluate(node.left)) != parseFloat(evaluate(node.right)))
						return evaluate(node.leftAction);
					else 
						return evaluate(node.rightAction);
				}
				else if (node.value == "=") 
				{
					if(parseFloat(evaluate(node.left)) == parseFloat(evaluate(node.right)))
						return evaluate(node.leftAction);
					else 
						return evaluate(node.rightAction);
				}
			}			
			else if (operations.indexOf(node.value) != -1)
			{
				if (node.value == "*")
					return String(parseFloat(evaluate(node.left)) * parseFloat(evaluate(node.right)));
				else if (node.value == "/")
					return String(parseFloat(evaluate(node.left)) / parseFloat(evaluate(node.right)));
				else if (node.value == "+")
					return String(parseFloat(evaluate(node.left)) + parseFloat(evaluate(node.right)));
				else if (node.value == "-")
					return String(parseFloat(evaluate(node.left)) - parseFloat(evaluate(node.right)));
			}			
			else if (actions.indexOf(node.value) != -1)
			{
				if (node.value == "bet1")
				{	
				}
			}
			else if(variables.indexOf(node.value) != -1)
			{
				if (node.value == "odd1")
					return "";
				
			}
			
			return node.value;
		}
	}
}
