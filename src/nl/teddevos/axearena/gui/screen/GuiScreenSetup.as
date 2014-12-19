package nl.teddevos.axearena.gui.screen 
{
	import nl.teddevos.axearena.gui.component.GuiButton;
	import nl.teddevos.axearena.gui.component.GuiButtonImage;
	import nl.teddevos.axearena.gui.component.GuiButtonImageSelect;
	import nl.teddevos.axearena.gui.component.GuiButtonImageToggle;
	import nl.teddevos.axearena.gui.GuiScreen;
	import starling.display.Image;
	import starling.display.Quad;
	import nl.teddevos.axearena.graphics.AssetList;
	import starling.text.TextField;
	import nl.teddevos.axearena.gui.SwitchGuiEvent;
	
	public class GuiScreenSetup extends GuiScreen
	{
		public var SLOT_EMPTY:int = 0;
		public var SLOT_PLAYER_WASD:int = 1;
		public var SLOT_PLAYER_ARROWS:int = 2;
		public var SLOT_AI_EASY:int = 3;
		public var SLOT_AI_MEDIUM:int = 4;
		public var SLOT_AI_HARD:int = 5;
		
		public var playerbuttons:Vector.<GuiButtonImageSelect>;
		
		public function GuiScreenSetup() 
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
			
			var button_start:GuiButton = addButton(new GuiButtonImage(0, AssetList.assets.getTexture("button_small.png"), "Start game", 0xFFFFFF, 35, width * 0.5 - 150 - 230, 640));
			var button_back:GuiButton = addButton(new GuiButtonImage(1, AssetList.assets.getTexture("button_small.png"), "Back to menu", 0xFFFFFF, 35, width * 0.5 - 150 + 230, 640));
			
			var text_players:TextField = new TextField(300, 50, "Players:", "GameTitleFont", 40, 0xFFFFFF);
			text_players.x = width * 0.15;
			text_players.y = height * 0.12;
			text_players.hAlign = "left";
			addChild(text_players);
			
			playerbuttons = new Vector.<GuiButtonImageSelect>();
			for (var i:int = 0; i < 4; i++ )
			{
				var b:GuiButtonImageSelect = new GuiButtonImageSelect(99, AssetList.assets.getTexture("button_low.png"), "", 0xFFFFFF, 35, width * 0.34 - 250, height * 0.19 + i * 60, i == 0 ? 1 : 3, new < String > [" Empty", " Player (WASD, SPACE)", " Player (ARROWS, SHIFT)", " Computer AI"]);
				b.text.hAlign = "left";
				b.img.color = i == 0 ? 0xFF0000 : i == 1 ? 0x0000FF : i == 2 ? 0x00FF00 : 0xFFFF00;
				playerbuttons.push(b);
				addButton(b);
			}
		}
		
		override public function action(g:GuiButton):void
		{
			if (g.buttonID == 0)
			{
				var v:Vector.<int> = new Vector.<int>();
				for (var i:int = 0; i < 4; i++ )
				{
					v.push(playerbuttons[i].state);
				}
				
				dispatchEvent(new SwitchGuiEvent(SwitchGuiEvent.NEWGUI, new GuiScreenGame(v), true));
			}
			else if (g.buttonID == 1)
			{
				dispatchEvent(new SwitchGuiEvent(SwitchGuiEvent.NEWGUI, new GuiScreenMenu(), true));
			}
		}
	}
}