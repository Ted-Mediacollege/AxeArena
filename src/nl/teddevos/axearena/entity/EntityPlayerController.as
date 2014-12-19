package nl.teddevos.axearena.entity 
{
	import Box2D.Common.Math.b2Vec2;
	import nl.teddevos.axearena.world.World;
	//import io.arkeus.ouya.controller.Xbox360Controller;
	//import nl.teddevos.axearena.data.ControllerSupport;
	
	public class EntityPlayerController //extends EntityPlayerBase
	{	
		/*public var controller:Xbox360Controller;
		public var controllerFound:Boolean = false;
		
		public function EntityPlayerController(i:int, px:Number, py:Number, world:World) 
		{
			super(i, px, py, world);
			if (ControllerSupport.controllerLength > 0)
			{
				controller = ControllerSupport.controllers[0];
			}
		}
		
		override public function tick(world:World):void
		{
			movePlayer(world);
			
			if (controllerFound)
			{
				if (controller.a.held) //JUMP
				{
					UP = true;
				}
				else
				{
					UP = false;
				}
				
				if (controller.x.held) //AXE
				{
					AXE = true;
				}
				else
				{
					AXE = false;
					AXEREADY = true;
				}
			}
		}*/
	}
}