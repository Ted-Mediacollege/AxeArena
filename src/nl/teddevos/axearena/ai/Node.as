package nl.teddevos.axearena.ai 
{
	public class Node 
	{
		public var pathIds:Vector.<int>;
		public var paths:Vector.<Path>;
		public var x:Number;
		public var y:Number;
		
		public function Node(p:Vector.<Path>, tx:Number, ty:Number) 
		{
			x = tx + 0.5;
			y = ty - 0.1;
			paths = p;
			
			var l:int = paths.length;
			pathIds = new Vector.<int>(l);
			for (var i:int = 0; i < l; i++ )
			{
				pathIds[i] = paths[i].to;
			}
		}
		
		public function getPath(to:int):Path
		{
			var l:int = paths.length;
			for (var i:int = 0; i < l; i++)
			{
				if (paths[i].to == to)
				{
					return paths[i];
				}
			}
			
			return paths[0];
		}
	}
}