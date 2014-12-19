package nl.teddevos.axearena.ai 
{
	public class PathCalc 
	{
		public var route:Vector.<int>;
		public var distance:Number;
		public var currentNode:int;
		
		public function PathCalc(id:int, dis:Number, r:Vector.<int>) 
		{
			currentNode = id;
			distance = dis;
			route = r;
			route.push(currentNode);
		}
	}
}