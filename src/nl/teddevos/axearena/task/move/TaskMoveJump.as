package nl.teddevos.axearena.task.move 
{
	import nl.teddevos.axearena.entity.EntityPlayerBase;
	import nl.teddevos.axearena.world.World;
	import nl.teddevos.axearena.util.MathHelper;
	
	public class TaskMoveJump extends TaskMoveBase
	{
		private var ready:Boolean = false;
		private var startX:Number;
		private var startY:Number;
		
		public function TaskMoveJump(x:Number, y:Number, sx:Number, sy:Number) 
		{
			super(45, x, y);
			startX = sx;
			startY = sy;
		}
		
		override public function tick(world:World, player:EntityPlayerBase):void
		{
			if (ready)
			{
				player.UP = true;
					
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
				else if (player.posX < targetX)
				{
					player.LEFT = false;
					player.RIGHT = true;
				}
			}
			else if (world.isSolidAt(player.posX, player.posY + player.entityHeight + 2) && MathHelper.dis(player.posX, startX) < 15)
			{
				ready = true;
				player.UP = true;
					
				if (player.posX > targetX)
				{
					player.LEFT = true;
					player.RIGHT = false;
				}
				else if (player.posX < targetX)
				{
					player.LEFT = false;
					player.RIGHT = true;
				}
			}
			else
			{
				if (player.posX > startX)
				{
					player.LEFT = true;
					player.RIGHT = false;
				}
				else if (player.posX < startY)
				{
					player.LEFT = false;
					player.RIGHT = true;
				}
			}
		}
	}
}