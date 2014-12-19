package nl.teddevos.axearena.gui.screen 
{
	import nl.teddevos.axearena.gui.component.GuiButton;
	import nl.teddevos.axearena.gui.component.GuiButtonImage;
	import nl.teddevos.axearena.gui.GuiScreen;
	import starling.display.Image;
	import starling.display.Quad;
	import nl.teddevos.axearena.graphics.AssetList;
	import nl.teddevos.axearena.gui.SwitchGuiEvent;
	
	public class GuiScreenMenu extends GuiScreen
	{
		
		public function GuiScreenMenu() 
		{
			
			
		}
		
		override public function init():void
		{
			var bg:Image = new Image(AssetList.assets.getTexture("background_menu"));
			addChild(bg);
			
			var button_play:GuiButton = addButton(new GuiButtonImage(0, AssetList.assets.getTexture("button_default.png"), "Start game", 0xFFFFFF, 55, width * 0.5 - 250, 300));
			var button_settings:GuiButton = addButton(new GuiButtonImage(1, AssetList.assets.getTexture("button_default.png"), "Settings", 0xFFFFFF, 55, width * 0.5 - 250, 400));
			var button_quit:GuiButton = addButton(new GuiButtonImage(2, AssetList.assets.getTexture("button_default.png"), "Quit", 0xFFFFFF, 55, width * 0.5 - 250, 500));
		}
		
		override public function action(g:GuiButton):void
		{
			if (g.buttonID == 0)
			{
				dispatchEvent(new SwitchGuiEvent(SwitchGuiEvent.NEWGUI, new GuiScreenSetup(), true));
			}
			else if (g.buttonID == 1)
			{
				dispatchEvent(new SwitchGuiEvent(SwitchGuiEvent.NEWGUI, new GuiScreenSettings(), true));
			}
		}
	}
}