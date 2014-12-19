package nl.teddevos.axearena.entity 
{
	import flash.geom.Point;
	import nl.teddevos.axearena.world.World;
	import Box2D.Common.Math.b2Vec2;
	import starling.display.Quad;
	
	public class EntityPlayerBase extends EntityBase
	{
		public var UP:Boolean = false;
		public var LEFT:Boolean = false;
		public var RIGHT:Boolean = false;
		public var AXE:Boolean = false;
		protected var AXEREADY:Boolean = true;
		
		public var quad:Quad;
		
		public var axeLeft:int;
		public var id:int;
		
		public var deathTimer:int;
		
		public function EntityPlayerBase(i:int, px:Number, py:Number, world:World) 
		{
			super(px, py, 20, 40, world);
			
			quad = new Quad(entityWidth * 2, entityHeight * 2, i == 0 ? 0xFF0000 : i == 1 ? 0x0000FF : i == 2 ? 0x00FF00 : 0xFFFF00);
			quad.x = entityBody.GetPosition().x * 64 - entityWidth;
			quad.y = entityBody.GetPosition().y * 64 - entityHeight;
			addChild(quad);
			
			axeLeft = 3;
			id = i;
			deathTimer = -1;
		}
		
		public function movePlayer(world:World):void
		{
			if (!dead)
			{
				updateEntityPos();
				drawQuad();
				
				if (AXE && AXEREADY && axeLeft > 0)
				{
					AXEREADY = false;
					axeLeft--;
					world.projectiles.spawnAxe(id, posX, posY - entityHeight + 26, direction);
				}
				
				axeLeft += world.projectiles.pickupCheckAt(posX, posY, id);
				
				if (LEFT)
				{
					direction = -1;
				}
				if (RIGHT)
				{
					direction = 1;
				}
				
				if ((world.isSolidAt(entityBody.GetPosition().x * 64 - entityWidth, entityBody.GetPosition().y * 64 + entityHeight + 5) || world.isSolidAt(entityBody.GetPosition().x * 64 + entityWidth, entityBody.GetPosition().y * 64 + entityHeight + 5)) && entityBody.GetLinearVelocity().y >= 0)
				{
					if (UP)
					{
						entityBody.ApplyImpulse(new b2Vec2(0, -14.5 - entityBody.GetLinearVelocity().y), entityBody.GetPosition());
					}
					if (!LEFT && !RIGHT)
					{
						entityBody.ApplyImpulse(new b2Vec2( -entityBody.GetLinearVelocity().x, 0), entityBody.GetPosition());
					}
				}
				if (!(world.isSolidAt(entityBody.GetPosition().x * 64 - entityWidth - 10, entityBody.GetPosition().y * 64 + entityHeight) || world.isSolidAt(entityBody.GetPosition().x * 64 - entityWidth - 10, entityBody.GetPosition().y * 64) || world.isSolidAt(entityBody.GetPosition().x * 64 - entityWidth - 10, entityBody.GetPosition().y * 64 - entityHeight)) && LEFT && entityBody.GetLinearVelocity().x >= -5)
				{
					entityBody.ApplyImpulse(new b2Vec2(-5 - entityBody.GetLinearVelocity().x, 0), entityBody.GetPosition());
				}
				if (!(world.isSolidAt(entityBody.GetPosition().x * 64 + entityWidth + 10, entityBody.GetPosition().y * 64 + entityHeight) || world.isSolidAt(entityBody.GetPosition().x * 64 + entityWidth + 10, entityBody.GetPosition().y * 64) || world.isSolidAt(entityBody.GetPosition().x * 64 + entityWidth + 10, entityBody.GetPosition().y * 64 - entityHeight)) && RIGHT && entityBody.GetLinearVelocity().x <= 5)
				{
					entityBody.ApplyImpulse(new b2Vec2(5 - entityBody.GetLinearVelocity().x , 0), entityBody.GetPosition());
				}
			}
			else
			{
				deathTimer--;
				if (deathTimer < 0)
				{
					respawn();
					axeLeft = 3;
					var p:Point = world.getRandomSpawnPoint();
					entityBody.SetPosition(new b2Vec2(p.x / 64, p.y / 64));
				}
			}
		}		
		
		override public function respawn():void
		{
			visible = true;
			dead = false;
		}
		
		override public function die():void
		{
			entityBody.SetPosition(new b2Vec2(64 / 64, -150 / 64));
			entityBody.SetLinearVelocity(new b2Vec2(0, 0));
			visible = false;
			dead = true;
			deathTimer = 90;
			drawQuad();
			posX = 500;
			posY = -10000;
		}
		
		public function drawQuad():void
		{
			quad.x = entityBody.GetPosition().x * 64 - entityWidth;
			quad.y = entityBody.GetPosition().y * 64 - entityHeight;
		}
	}
}