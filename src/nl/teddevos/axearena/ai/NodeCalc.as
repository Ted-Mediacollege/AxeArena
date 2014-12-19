package nl.teddevos.axearena.ai 
{
	public class NodeCalc 
	{
		public var shortest:Number = int.MAX_VALUE;
		public var x:Number;
		public var y:Number;
		public var connections:Vector.<int>;
		
		public function NodeCalc(px:Number, py:Number, c:Vector.<int>) 
		{
			x = px;
			y = py;
			connections = c;
		}
	}
}