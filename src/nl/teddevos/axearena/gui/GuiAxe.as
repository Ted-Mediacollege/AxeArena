package nl.teddevos.axearena.gui 
{
	import starling.display.Image;
	import starling.textures.Texture;
	import nl.teddevos.axearena.util.MathHelper;
	
	public class GuiAxe extends Image
	{
		public var posX:Number;
		public var posY:Number;
		public var velX:Number;
		public var velY:Number;
		public var targetX:Number;
		public var targetY:Number;
		public var targetReached:Boolean;
		
		public function GuiAxe(t:Texture, tX:Number, tY:Number) 
		{
			super(t);
			
			targetReached = false;
			targetX = tX;
			targetY = tY;
			posX = targetX - 400 + Math.random() * 800;
			posX = Math.min(posX, 1230);
			posX = Math.max(posX, 50);
			
			posY = 800;
			
			pivotX = 25;
			pivotY = 25;
			
			x = -100;
			y = -100;
			
			var dir:Number = MathHelper.pointToDegree(posX, posY, targetX, targetY);
			velX = Math.cos(dir / 180 * Math.PI);
			velY = Math.sin(dir / 180 * Math.PI);
		}
	}
}