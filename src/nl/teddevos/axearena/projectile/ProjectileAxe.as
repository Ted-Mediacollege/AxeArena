package nl.teddevos.axearena.projectile 
{
	public class ProjectileAxe 
	{		
		public var posX:Number;
		public var posY:Number;
		public var velX:Number;
		public var velY:Number;
		public var rotation:Number;
		public var stuck:Boolean;
		public var owner:int;
		public var rotating:Boolean;
		
		public function ProjectileAxe(px:Number, py:Number, vx:Number, vy:Number, rot:Number, o:int) 
		{
			posX = px;
			posY = py;
			velX = vx;
			velY = vy;
			rotation = rot;
			owner = o;
			stuck = false;
			rotating = true;
		}	
	}
}