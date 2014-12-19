package nl.teddevos.axearena.gui.screen 
{
	import nl.teddevos.axearena.gui.GuiScreen;
	import nl.teddevos.axearena.world.World;
	import starling.display.Quad;
	import flash.ui.Keyboard;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.events.TouchEvent;
	//import nl.teddevos.axearena.data.ControllerSupport;

	public class GuiScreenGame extends GuiScreen
	{
		public var world:World;
		public var players:Vector.<int>;
		
		public function GuiScreenGame(p:Vector.<int>) 
		{
			randomAxe = false;
			players = p;
			//ControllerSupport.init();
		}
		
		override public function init():void
		{
			world = new World(players);
			world.touchable = false;
			addChild(world);
		}
		
		override public function tick():void
		{
			world.tick();
		}
		
		override protected function onKeyDown(e:KeyboardEvent):void
		{
		}
		
		override protected function onKeyUp(e:KeyboardEvent):void
		{
		}
		
		override protected function onTouch(e:TouchEvent):void
		{
		}
	}
}