package nl.teddevos.axearena.task.move 
{
	import nl.teddevos.axearena.entity.EntityPlayerBase;
	import nl.teddevos.axearena.world.World;
	import nl.teddevos.axearena.util.MathHelper;
	
	public class TaskMovePortal extends TaskMoveBase
	{
		public function TaskMovePortal(x:Number, y:Number) 
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
			
			var fakeX:Number = targetX;
			if (MathHelper.dis(player.posX, targetX) > 300)
			{
				if (player.posX < fakeX)
				{
					fakeX -= 2000;
				}
				else if (player.posX > fakeX)
				{
					fakeX += 2000;
				}
			}
			
			if (player.posX > fakeX)
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