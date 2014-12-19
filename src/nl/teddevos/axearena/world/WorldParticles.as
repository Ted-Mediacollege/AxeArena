package nl.teddevos.axearena.world 
{
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import nl.teddevos.axearena.graphics.AssetList;
	import nl.teddevos.axearena.util.MathHelper;

	public class WorldParticles extends Sprite
	{
		public var particlesPX:Vector.<Number>;
		public var particlesPY:Vector.<Number>;
		public var particlesVX:Vector.<Number>;
		public var particlesVY:Vector.<Number>;
		public var particlesR:Vector.<Number>;
		public var particlesT:Vector.<Number>;
		public var particleLength:int;
		
		private var quadBatch:QuadBatch;
		private var image:Image;
		
		public function WorldParticles() 
		{
			particlesPX = new Vector.<Number>();
			particlesPY = new Vector.<Number>();
			particlesVX = new Vector.<Number>();
			particlesVY = new Vector.<Number>();
			particlesR = new Vector.<Number>();
			particlesT = new Vector.<Number>();
			particleLength = 0;
			
			quadBatch = new QuadBatch();
			addChild(quadBatch);
			
			image = new Image(AssetList.assets.getTexture("particle_blood"));
		}
		
		public function spawn(posX:Number, posY:Number):void
		{
			var amount:int = 30;
			var dir:Number;
			var sp:Number;
			for (var i:int = 0; i < amount; i++ )
			{
				dir = MathHelper.nextNumber(Math.PI * 2);
				sp = 8 + Math.random() * 8;
				
				particlesPX.push(posX);
				particlesPY.push(posY);
				particlesVX.push(Math.cos(dir) * sp);
				particlesVY.push(Math.sin(dir) * sp);
				particlesR.push(0);
				particlesT.push(30);
				particleLength++;
			}
		}
		
		public function tick():void
		{
			quadBatch.reset();
			
			for (var i:int = 0; i < particleLength; i++ )
			{
				particlesT[i]--;
				if (particlesT[i] < 0)
				{
					particlesPX.splice(i, 1);
					particlesPY.splice(i, 1);
					particlesVX.splice(i, 1);
					particlesVY.splice(i, 1);
					particlesR.splice(i, 1);
					particlesT.splice(i, 1);
					particleLength--;
				}
				else
				{
					particlesPX[i] += particlesVX[i];
					particlesPY[i] += particlesVY[i] += 1;
					image.x = particlesPX[i];
					image.y = particlesPY[i];
					image.alpha = Math.min(particlesT[i] / 10, 1);
					quadBatch.addImage(image);
				}
			}
		}
	}
}