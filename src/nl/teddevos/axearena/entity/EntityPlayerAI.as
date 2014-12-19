package nl.teddevos.axearena.entity 
{
	import Box2D.Common.Math.b2Vec2;
	import nl.teddevos.axearena.ai.Path;
	import nl.teddevos.axearena.task.move.TaskMoveBase;
	import nl.teddevos.axearena.task.move.TaskMoveJump;
	import nl.teddevos.axearena.task.move.TaskMovePortal;
	import nl.teddevos.axearena.task.move.TaskMoveWalk;
	import nl.teddevos.axearena.world.World;
	import nl.teddevos.axearena.util.MathHelper;
	
	public class EntityPlayerAI extends EntityPlayerBase
	{
		public var delay:int = 0;
		public var taskMove:TaskMoveBase;
		public var targetPlayer:EntityPlayerBase;
		public var randomAxe:int;
		public var axeReady:int;
		
		public var stuck:int;
		public var stuckDir:int;
		public var prevX:Number;
		
		public function EntityPlayerAI(i:int, px:Number, py:Number, world:World) 
		{
			super(i, px, py, world);
			randomAxe = 60;
			stuck = 0;
			stuckDir = direction;
			axeReady = 0;
		}
		
		override public function tick(world:World):void
		{
			movePlayer(world);
			if (!dead)
			{
				if (targetPlayer != null && MathHelper.dis(targetPlayer.posY, posY) < 200 && MathHelper.dis(targetPlayer.posX, posX) < 600 && axeLeft > 0)
				{
					axeReady++;
				}
				else
				{
					axeReady = 0;
				}
				
				randomAxe--;
				if (randomAxe < 0 && MathHelper.nextInt(int(MathHelper.dis(targetPlayer.posX, posX) / 20)) == 0 && axeReady > 15)
				{
					randomAxe = 5;
					if (targetPlayer != null && MathHelper.dis(targetPlayer.posY, posY) < 100 && MathHelper.dis(targetPlayer.posX, posX) < 600 && axeLeft > 0)
					{
						world.projectiles.spawnAxe(id, posX, posY - entityHeight + 26, targetPlayer.posX > posX ? 1 : -1);
						axeLeft--;
					}
				}
				
				if (taskMove == null || taskMove.time < 0 || (MathHelper.dis(taskMove.targetX, posX) < 15 && (posY < taskMove.targetY || MathHelper.dis(taskMove.targetY, posY) < 30)))
				{
					delay = 30;
					
					targetPlayer = world.getClosestPlayerTarget(this);
					var nodeEnemy:int = world.pathManager.getClosestNode(targetPlayer.posX, targetPlayer.posY);
					var nodePlayer:int = world.pathManager.getClosestNode(posX, posY);
					var path:Vector.<int> = world.pathManager.getPathFromTo(nodePlayer, nodeEnemy);
					
					if (MathHelper.dis(posX, world.pathManager.NODES[path[0]].x * 64) < 15)
					{
						var pa:Path = world.pathManager.NODES[path[0]].getPath(path[1]);
						if (pa.type == 2)
						{
							taskMove = new TaskMovePortal(world.pathManager.NODES[path[1]].x * 64, world.pathManager.NODES[path[1]].y * 64);
							//trace("portal to", path[1]);
						}
						else if (pa.type == 1)
						{
							taskMove = new TaskMoveJump(world.pathManager.NODES[path[1]].x * 64, world.pathManager.NODES[path[1]].y * 64, world.pathManager.NODES[path[0]].x * 64, world.pathManager.NODES[path[0]].y * 64);
							//trace("jump to", path[1]);
						}
						else if (pa.type == 0)
						{
							taskMove = new TaskMoveWalk(world.pathManager.NODES[path[1]].x * 64, world.pathManager.NODES[path[1]].y * 64);
							//trace("walk to", path[1]);
						}
					}
					else
					{
						taskMove = new TaskMoveWalk(world.pathManager.NODES[path[0]].x * 64, world.pathManager.NODES[path[0]].y * 64);
						//trace("start at", path[0]);
					}
				}
				else if(taskMove.time > -1)
				{
					taskMove.time--;
					taskMove.tick(world, this);
				}
				
				stuckCheck();
				prevX = posX;
			}
		}
		
		public function stuckCheck():void
		{
			if (stuckDir == direction && ((RIGHT && posX - prevX < 0.02) || (LEFT && prevX - posX < 0.02)))
			{
				stuck++;
				if (stuck > 60)
				{
					UP = true;
				}
			}
			else if (stuckDir != direction)
			{
				stuckDir = direction;
				stuck = 0;
			}
			else
			{
				stuck = 0;
			}
		}
	}
}