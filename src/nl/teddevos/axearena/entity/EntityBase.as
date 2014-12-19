package nl.teddevos.axearena.entity 
{
	import nl.teddevos.axearena.world.World;
	import starling.display.Quad;
	import starling.display.Sprite;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	public class EntityBase extends Sprite
	{
		public var entityShape:b2PolygonShape= new b2PolygonShape();
		public var entityDef:b2BodyDef = new b2BodyDef();
		public var entityBody:b2Body;
		public var entityFixture:b2FixtureDef;
		
		public var entityWidth:Number = 0;
		public var entityHeight:Number = 0;
		
		public var posX:Number;
		public var posY:Number;
		public var direction:int;
		
		public var dead:Boolean = false;
		public var score:int = 0;
			
		public function EntityBase(px:Number, py:Number, w:Number, h:Number, world:World) 
		{
			entityShape = new b2PolygonShape();
			entityDef = new b2BodyDef();
			
			entityWidth = w;
			entityHeight = h;
			
			posX = px;
			posY = py;
			direction = 1;
			
			entityDef.type = b2Body.b2_dynamicBody;
			entityDef.fixedRotation = true;
			entityDef.position.Set(posX / 64, posY / 64);
			entityShape.SetAsBox(w / 64, h / 64);
			entityFixture = new b2FixtureDef();
			entityFixture.shape = entityShape;
			entityFixture.density = 1.8;
			entityFixture.friction = 2;
			entityFixture.restitution = 0;
			entityFixture.filter.categoryBits = 2;
			entityFixture.filter.groupIndex = -2;
			
			entityBody = world.box2dworld.CreateBody(entityDef);
			//entityBody.CreateFixture2(entityShape);
			
			entityBody.CreateFixture(entityFixture);
		}
		
		public function respawn():void
		{
		}
		
		public function die():void
		{
		}
		
		public function updateEntityPos():void
		{
			if (!dead)
			{
				posX = entityBody.GetPosition().x * 64;
				posY = entityBody.GetPosition().y * 64;
				
				if (posX < 0)
				{
					posX += 1280;
					entityBody.SetPosition(new b2Vec2(posX / 64, posY / 64));
				}
				if (posY < 0)
				{
					posY += 768;
					entityBody.SetPosition(new b2Vec2(posX / 64, posY / 64));
				}
				if (posX > 1280)
				{
					posX -= 1280;
					entityBody.SetPosition(new b2Vec2(posX / 64, posY / 64));
				}
				if (posY > 768)
				{
					posY -= 768;
					entityBody.SetPosition(new b2Vec2(posX / 64, posY / 64));
				}
			}
		}
		
		public function tick(world:World):void
		{
		}
	}
}