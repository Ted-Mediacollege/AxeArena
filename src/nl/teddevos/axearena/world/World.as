package nl.teddevos.axearena.world 
{
	import Box2D.Dynamics.b2World;
	import nl.teddevos.axearena.ai.PathManager;
	import nl.teddevos.axearena.entity.EntityBase;
	import nl.teddevos.axearena.entity.EntityPlayerAI;
	import nl.teddevos.axearena.entity.EntityPlayerBase;
	import nl.teddevos.axearena.entity.EntityPlayerController;
	import nl.teddevos.axearena.entity.EntityPlayerKeyboard;
	import starling.display.Quad;
	import starling.display.Sprite;
	import nl.teddevos.axearena.data.LevelLayout;
	import starling.display.Image;
	import nl.teddevos.axearena.graphics.AssetList;
	import flash.geom.Point;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import nl.teddevos.axearena.util.MathHelper;

	public class World extends Sprite
	{
		public var background:WorldBackground;
		public var projectiles:WorldProjectile;
		public var particles:WorldParticles;
		public var pathManager:PathManager;
		
		public var level:Vector.<int>;
		public var players:Vector.<EntityPlayerBase>;
		
		public var box2dworld:b2World;
		
		public function World(p:Vector.<int>) 
		{
			level = LevelLayout.getLevelLayoutByID(0);
			pathManager = new PathManager();
			
			var bg:Image = new Image(AssetList.assets.getTexture("background_level"));
			addChild(bg);
			
			background = new WorldBackground(level);
			background.touchable = false;
			addChild(background);
			
			particles = new WorldParticles();
			addChild(particles);
			
			box2dworld = new b2World(new b2Vec2(0.0, 20.0), true);

			var tileShape:b2PolygonShape= new b2PolygonShape();
			var tileDef:b2BodyDef = new b2BodyDef();
			var tileBody:b2Body;
			var id:int = 0;
			
			for (var i:int = 0; i < 20; i++ )
			{
				for (var j:int = 0; j < 12; j++ )
				{
					id = level[j * 20 + i];
					if (id > 0 && id < 50)
					{
						tileDef.position.Set((i * 64 + 32) / 64, (j * 64 + 32) / 64);
						tileShape.SetAsBox((32 / 64), (32 / 64));
						tileBody = box2dworld.CreateBody(tileDef);
						tileBody.CreateFixture2(tileShape);
					}
				}
			}
			
			players = new Vector.<EntityPlayerBase>();
			var l:int = p.length;
			var ii:int = 0;
			for (var a:int = 0; a < l; a++ )
			{
				var po:Point = getRandomSpawnPoint();
				
				var pl:EntityPlayerBase;
				switch(p[a])
				{
					case 0: break; //EMPTY
					case 1: pl = new EntityPlayerKeyboard(ii, po.x, po.y, this, 0); break; //PLAYER WASD
					case 2: pl = new EntityPlayerKeyboard(ii, po.x, po.y, this, 1); break; //PLAYER ARROWS
					//case 3: pl = new EntityPlayerController(ii, po.x, po.y, this); break; //CONTROLLER
					case 3: pl = new EntityPlayerAI(ii, po.x, po.y, this); break; //COMPUTER AI
				}
				
				if (pl != null)
				{
					addChild(pl);
					players.push(pl);
					ii++;
				}
			}
			
			projectiles = new WorldProjectile();
			addChild(projectiles);
			addChild(pathManager);
		}
		
		public function tick():void
		{
			box2dworld.Step(0.0333, 10, 10);
			
			var l:int = players.length;
			for (var i:int = 0; i < l; i++ )
			{
				players[i].tick(this);
			}
			
			projectiles.tick(this);
			particles.tick();
		}
		
		public function isSolidAt(px:Number, py:Number):Boolean
		{
			if (px < 0 || py < 0 || px > 1279 || py > 767)
			{
				return false;
			}
			
			px /= 64;
			py /= 64;
			
			var id:int = level[int(py) * 20 + int(px)];
			if (id > 0 && id < 50)
			{
				return true;
			}
			return false;
		}
		
		public function getClosestPlayerTarget(player:EntityPlayerBase):EntityPlayerBase
		{
			var l:int = players.length;
			
			if (l < 2)
			{
				throw new Error("Not enough players!");
			}
			
			var closestDistance:Number = Number.MAX_VALUE;
			var closestPlayer:int = 0;
			var dist:Number;
			
			for (var i:int = 0; i < l; i++ )
			{
				dist = MathHelper.dis2(players[i].posX, players[i].posY, player.posX, player.posY);
				if (dist < closestDistance && player.id != i)
				{
					closestDistance = dist;
					closestPlayer = i;
				}
			}
			
			return players[closestPlayer];
		}
		
		public function getRandomSpawnPoint():Point
		{
			var p:Point;
			while (true)
			{
				p = pathManager.getRandomNode();
				if (!isSolidAt(p.x * 64, p.y * 64))
				{
					return new Point(p.x * 64, p.y * 64);
				}
			}
			return new Point(200, 200);
		}
	}
}