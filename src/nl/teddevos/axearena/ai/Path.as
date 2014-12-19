package nl.teddevos.axearena.ai 
{
	public class Path 
	{
		public var type:int;
		public var from:int;
		public var to:int;
		
		public function Path(ty:int, f:int, t:int) 
		{
			type = ty;
			from = f;
			to = t;
		}
	}
}