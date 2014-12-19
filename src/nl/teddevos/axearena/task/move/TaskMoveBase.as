package nl.teddevos.axearena.task.move 
{
	import nl.teddevos.axearena.entity.EntityPlayerBase;
	import nl.teddevos.axearena.world.World;
	
	public class TaskMoveBase 
	{
		public var time:int;
		
		public var targetX:Number;
		public var targetY:Number;
		
		public function TaskMoveBase(t:int, x:Number, y:Number) 
		{
			time = t;
			targetX = x;
			targetY = y;
		}
		
		public function tick(world:World, player:EntityPlayerBase):void
		{
		}
	}
}