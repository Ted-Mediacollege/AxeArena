package nl.teddevos.axearena.task.move 
{
	import nl.teddevos.axearena.entity.EntityPlayerBase;
	import nl.teddevos.axearena.world.World;
	import nl.teddevos.axearena.util.MathHelper;
	
	public class TaskMoveWalk extends TaskMoveBase
	{
		public function TaskMoveWalk(x:Number, y:Number) 
		{
			super(30, x, y);
		}
		
		override public function tick(world:World, player:EntityPlayerBase):void
		{
			if (world.isSolidAt(player.posX + player.entityWidth + 5, player.posY + player.entityHeight - 5) || world.isSolidAt(player.posX - player.entityWidth - 5, player.posY + player.entityHeight - 5))
			{
				player.UP = true;
			}
			else
			{
				player.UP = false;
			}
			
			if (MathHelper.dis(player.posX, targetX) < 10)
			{
				player.LEFT = false;
				player.RIGHT = false;
			}
			else if (player.posX > targetX)
			{
				player.LEFT = true;
				player.RIGHT = false;
			}
			else
			{
				player.LEFT = false;
				player.RIGHT = true;
			}
		}
	}
}