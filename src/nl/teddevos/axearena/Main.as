package nl.teddevos.axearena 
{
	import nl.teddevos.axearena.gui.GuiAxeLayer;
	import nl.teddevos.axearena.gui.screen.GuiScreenLoading;
	import starling.display.Quad;
	import starling.display.Sprite;
	import nl.teddevos.axearena.gui.GuiScreen;
	import nl.teddevos.axearena.gui.SwitchGuiEvent;
	import starling.events.EnterFrameEvent;
	import flash.geom.Rectangle;
	import nl.teddevos.axearena.graphics.AssetList;
	
	public class Main extends Sprite
	{
		public var gui:GuiScreen;
		public var axeLayer:GuiAxeLayer;
		
		public function Main() 
		{
			gui = new GuiScreenLoading();
			addChild(gui);
			gui.preInit(this);
			gui.init();
			
			axeLayer = new GuiAxeLayer();
			axeLayer.touchable = false;
			addChild(axeLayer);
			
			clipRect = new Rectangle(0, 0, 1280, 768);
			
			addEventListener(SwitchGuiEvent.NEWGUI, switchGui);
			addEventListener(EnterFrameEvent.ENTER_FRAME, tick);
		}
		
		public function tick(e:EnterFrameEvent):void
		{
			gui.preTick();
			gui.tick();
			axeLayer.tick();
		}
		
		public function switchGui(e:SwitchGuiEvent):void
		{
			removeChild(gui);
			gui.preDestroy();
			gui.destroy();
			gui = e.guiscreen;
			addChildAt(gui, 0);
			gui.preInit(this);
			gui.init();
		}
	}
}