package nl.teddevos.axearena.gui.screen 
{
	import nl.teddevos.axearena.gui.component.GuiButtonImageToggle;
	import nl.teddevos.axearena.gui.GuiScreen;
	import nl.teddevos.axearena.gui.component.GuiButton;
	import nl.teddevos.axearena.graphics.AssetList;
	import starling.display.Image;
	import starling.text.TextField;
	import nl.teddevos.axearena.gui.component.GuiButtonImage;
	import nl.teddevos.axearena.gui.SwitchGuiEvent;
	import nl.teddevos.axearena.data.Settings;
	import nl.teddevos.axearena.PreLoader;

	public class GuiScreenSettings extends GuiScreen
	{
		public function GuiScreenSettings() 
		{
			
		}
		
		override public function init():void
		{
			var bg:Image = new Image(AssetList.assets.getTexture("background_menu"));
			addChild(bg);

			var box:Image = new Image(AssetList.assets.getTexture("box.png"));
			box.x = screenWidth * 0.5 - (box.width / 2);
			box.y = screenHeight * 0.5 - (box.height / 2);
			addChild(box);
			
			var text_title:TextField = new TextField(300, 80, "Settings", "GameTitleFont", 70, 0xFFFFFF);
			text_title.x = width * 0.5 - 150;
			text_title.y = height * 0.1;
			addChild(text_title);
			
			var button_back:GuiButton = addButton(new GuiButtonImage(0, AssetList.assets.getTexture("button_small.png"), "Back to menu", 0xFFFFFF, 35, width * 0.5 - 150, 640));
			
			var button_settings_axe:GuiButton = addButton(new GuiButtonImageToggle(10, AssetList.assets.getTexture("button_low.png"), "", 0xFFFFFF, 35, width * 0.5 - 250, 200, Settings.RANDOM_AXE, "Random axe: ON", "Random axe: OFF"));
			var button_settings_debug:GuiButton = addButton(new GuiButtonImageToggle(11, AssetList.assets.getTexture("button_low.png"), "", 0xFFFFFF, 35, width * 0.5 - 250, 270, Settings.DEBUG, "Debug: ON", "Debug: OFF"));
			
		}
		
		override public function action(g:GuiButton):void
		{
			if (g.buttonID == 0)
			{
				dispatchEvent(new SwitchGuiEvent(SwitchGuiEvent.NEWGUI, new GuiScreenMenu(), true));
			}
			else if (g.buttonID == 10)
			{
				Settings.RANDOM_AXE = !Settings.RANDOM_AXE;
			}
			else if (g.buttonID == 11)
			{
				Settings.DEBUG = !Settings.DEBUG;
				PreLoader.preloader.starling.showStats = Settings.DEBUG;
			}
		}
	}
}