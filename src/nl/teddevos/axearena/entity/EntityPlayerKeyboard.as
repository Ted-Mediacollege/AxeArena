package nl.teddevos.axearena.entity 
{
	import Box2D.Common.Math.b2Vec2;
	import nl.teddevos.axearena.world.World;
	import starling.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class EntityPlayerKeyboard extends EntityPlayerBase
	{
		public var WASD:Boolean;
		public var ARROWS:Boolean;
		
		public function EntityPlayerKeyboard(i:int, px:Number, py:Number, world:World, keySet:int) 
		{
			super(i, px, py, world);
			
			WASD = keySet == 0 ? true : false;
			ARROWS = keySet == 1 ? true : false;
			
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		override public function tick(world:World):void
		{
			movePlayer(world);
		}
		
		public function onKeyDown(e:KeyboardEvent):void
		{
			if (WASD)
			{
				if (e.keyCode == Keyboard.W)
				{
					UP = true;
				}
				if (e.keyCode == Keyboard.A)
				{
					LEFT = true;
				}
				if (e.keyCode == Keyboard.D)
				{
					RIGHT = true;
				}
				if (e.keyCode == Keyboard.SPACE)
				{
					AXE = true;
				}
			}
			else if (ARROWS)
			{
				if (e.keyCode == Keyboard.UP)
				{
					UP = true;
				}
				if (e.keyCode == Keyboard.LEFT)
				{
					LEFT = true;
				}
				if (e.keyCode == Keyboard.RIGHT)
				{
					RIGHT = true;
				}
				if (e.keyCode == Keyboard.SHIFT)
				{
					AXE = true;
				}
			}
		}
		
		public function onKeyUp(e:KeyboardEvent):void
		{
			if (WASD)
			{
				if (e.keyCode == Keyboard.W)
				{
					UP = false;
				}
				if (e.keyCode == Keyboard.A)
				{
					LEFT = false;
				}
				if (e.keyCode == Keyboard.D)
				{
					RIGHT = false;
				}
				if (e.keyCode == Keyboard.SPACE)
				{
					AXE = false;
					AXEREADY = true;
				}
			}
			else if (ARROWS)
			{
				if (e.keyCode == Keyboard.UP)
				{
					UP = false;
				}
				if (e.keyCode == Keyboard.LEFT)
				{
					LEFT = false;
				}
				if (e.keyCode == Keyboard.RIGHT)
				{
					RIGHT = false;
				}
				if (e.keyCode == Keyboard.SHIFT)
				{
					AXE = false;
					AXEREADY = true;
				}
			}
		}
	}
}