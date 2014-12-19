package nl.teddevos.axearena.gui.screen 
{
	import nl.teddevos.axearena.gui.GuiScreen;
	import nl.teddevos.axearena.gui.SwitchGuiEvent;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.textures.Texture;
	import nl.teddevos.axearena.graphics.AssetList;
	import starling.utils.AssetManager;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import nl.teddevos.axearena.data.Settings;
	
	public class GuiScreenLoading extends GuiScreen
	{
		[Embed(source="../../../../../../lib/background/AxeArenaLoading.png")]
		private var background:Class;
		
		private var text_loading:TextField;
		
		private var delay:int;
		private var dots:int;
		
		public function GuiScreenLoading() 
		{
		}
		
		override public function init():void
		{
			var img:Image = new Image(Texture.fromBitmap(new background())); 
			addChild(img);
			
			text_loading = new TextField(600, 200, "LOADING...", "GameTitleFont", 60, 0xFFFFFF, false);
			text_loading.hAlign = "left";
			text_loading.x = screenWidth * 0.5 - 120;
			text_loading.y = screenHeight * 0.8 - 100;
			addChild(text_loading);
			
			AssetList.init();
			
			delay = 60;
		}
		
		override public function tick():void
		{
			delay--;
			if (delay > 0)
			{
				dots++;
				if (dots == 40)
				{
					dots = 0;
				}
				text_loading.text = "LOADING";
				var d:int = int(dots / 10);
				while (d > 0)
				{
					d--;
					text_loading.text = text_loading.text + ".";
				}
			}
			else if (delay == 0)
			{
				text_loading.text = "Press key to continue.";
				text_loading.hAlign = "center";
				text_loading.fontSize = 50;
				text_loading.x = screenWidth * 0.5 - 300;
			}
		}
		
		override protected function onKeyDown(e:KeyboardEvent):void
		{
			if (delay < 0)
			{
				dispatchEvent(new SwitchGuiEvent(SwitchGuiEvent.NEWGUI, new GuiScreenMenu(), true));
			}
		}
		
		override protected function onTouch(e:TouchEvent):void
		{
			if (e.getTouch(this) && e.getTouch(this).phase == TouchPhase.ENDED)
			{
				if (AssetList.loaded)
				{
					if (Settings.RANDOM_AXE)
					{
						main.axeLayer.spawn(mX, mY);
					}
				}
				if (delay < 0)
				{
					dispatchEvent(new SwitchGuiEvent(SwitchGuiEvent.NEWGUI, new GuiScreenMenu(), true));
				}
			}
		}
	}
}