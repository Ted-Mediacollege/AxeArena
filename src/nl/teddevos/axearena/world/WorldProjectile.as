package nl.teddevos.axearena.world 
{
	import nl.teddevos.axearena.projectile.ProjectileAxe;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import nl.teddevos.axearena.graphics.AssetList;
	import starling.textures.Texture;
	import nl.teddevos.axearena.util.MathHelper;
	
	public class WorldProjectile extends Sprite
	{		
		private var textures:Vector.<Texture>;
		private var images:Vector.<Image>;
		private var projectiles:Vector.<ProjectileAxe>;
		private var batch:QuadBatch;
		private var projectileLength:int;
		
		public function WorldProjectile() 
		{
			images = new Vector.<Image>();
			textures = AssetList.assets.getTextures("axe0");
			for (var i:int = 0; i < 4; i++ )
			{
				var img:Image = new Image(textures[i]);
				img.pivotX = img.width * 0.5;
				img.pivotY = img.height * 0.5;
				images.push(img);
			}
			
			projectiles = new Vector.<ProjectileAxe>();
			batch = new QuadBatch();
			addChild(batch);
			projectileLength = 0;
		}	
		
		public function spawnAxe(owner:int, posX:Number, posY:Number, dir:int):void
		{
			var axe:ProjectileAxe = new ProjectileAxe(posX, posY, dir * 20, -1, 0, owner);
			projectiles.push(axe);
			projectileLength++;
		}
		
		public function removeAllFrom(owner:int):void
		{
			for (var i:int = projectileLength - 1; i > -1; i-- )
			{
				if (projectiles[i].owner == owner)
				{
					projectiles.splice(i, 1);
					projectileLength--;
				}
			}
		}
		
		public function pickupCheckAt(posX:Number, posY:Number, owner:int):int
		{
			var found:int = 0;
			for (var i:int = projectileLength - 1; i > -1; i-- )
			{
				if (projectiles[i].owner == owner && MathHelper.dis2(projectiles[i].posX, projectiles[i].posY, posX, posY) < 80 && projectiles[i].stuck)
				{
					projectiles.splice(i, 1);
					projectileLength--;
					found++;
				}
			}
			return found;
		}
		
		public function returnAxe(world:World, axe:ProjectileAxe):void
		{
			var l:int = world.players.length;
			for (var i:int = 0; i < l; i++ )
			{
				if (world.players[i].id == axe.owner)
				{
					world.players[i].axeLeft++;
					break;
				}
			}
		}
		
		public function tick(world:World):void
		{
			batch.reset();
			
			var projectile:ProjectileAxe;
			var img:Image;
			
			var l:int = world.players.length;
			var j:int = 0;
			var deaths:Vector.<int> = new Vector.<int>();
			for (var i:int = projectileLength - 1; i > -1; i-- )
			{
				projectile = projectiles[i];
				if (!projectile.stuck)
				{
					if (projectile.rotating)
					{
						projectile.rotation += 0.5;
					}
					projectile.velY += 0.5;
					projectile.posX += projectile.velX;
					projectile.posY += projectile.velY;
					
					if (projectile.posX < 0)
					{
						projectile.posX += 1280;
					}
					if (projectile.posX > 1279)
					{
						projectile.posX -= 1280;
					}
					if (projectile.posY < 0)
					{
						projectile.posY += 768;
					}
					if (projectile.posY > 767)
					{
						projectile.posY -= 768;
					}
				}
				
				if (projectile.velX < 0 && world.isSolidAt(projectile.posX - 25, projectile.posY))
				{
					projectile.velX = 0;
					projectile.velY = 0;
					projectile.rotating = false;
				}
				if (projectile.velX > 0 && world.isSolidAt(projectile.posX + 25, projectile.posY))
				{
					projectile.velX = 0;
					projectile.velY = 0;
					projectile.rotating = false;
				}
				if (projectile.velY < 0 && world.isSolidAt(projectile.posX, projectile.posY - 25))
				{
					projectile.velY = 0;
					projectile.rotating = false;
				}
				
				if (world.isSolidAt(projectile.posX, projectile.posY + 15))
				{
					projectile.stuck = true;
				}
				
				for (j = 0; j < l; j++ )
				{
					if (MathHelper.dis2(projectile.posX, projectile.posY, world.players[j].posX, world.players[j].posY) < 50 && !projectile.stuck && projectile.rotating && projectile.owner != world.players[j].id)
					{
						world.particles.spawn(world.players[j].posX, world.players[j].posY);
						returnAxe(world, projectile);
						projectiles.splice(i, 1);
						projectileLength--;
						world.players[j].die();
						deaths.push(j);
						break;
					}
				}
				
				img = images[projectile.owner];
				img.x = projectile.posX;
				img.y = projectile.posY;
				img.rotation = projectile.rotation;
				batch.addImage(img);
			}
			
			for (var b:int = 0; b < deaths.length; b++ )
			{
				removeAllFrom(deaths[b]);
			}
		}
	}
}