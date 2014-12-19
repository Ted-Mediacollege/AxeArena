package nl.teddevos.axearena.gui 
{
	import starling.display.Sprite;
	import nl.teddevos.axearena.Main;
	import nl.teddevos.axearena.gui.component.GuiButton;
	import starling.events.TouchEvent;
	import starling.events.KeyboardEvent;
	import nl.teddevos.axearena.PreLoader;
	import starling.events.TouchPhase;
	import starling.events.Touch;
	import nl.teddevos.axearena.data.Settings;
	
	public class GuiScreen extends Sprite
	{
		public var buttonList:Vector.<GuiButton>;
		public var main:Main;
		
		protected var screenWidth:int = 1280;
		protected var screenHeight:int = 768;
		
		protected var mX:Number;
		protected var mY:Number;
		
		protected var randomAxe:Boolean = true;
		
		public function GuiScreen() 
		{
		}
		
		public function preInit(m:Main):void
		{
			main = m;
			buttonList = new Vector.<GuiButton>();
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		public function init():void
		{
		}
		
		public function tick():void
		{
		}
		
		public function preTick():void
		{	
			mX = PreLoader.preloader.mouseX;
			mY = PreLoader.preloader.mouseY;

			for (var i:int = buttonList.length - 1; i > -1; i-- )
			{
				if (buttonList[i].posX < mX && 
					buttonList[i].posX + buttonList[i].buttonWidth > mX && 
					buttonList[i].posY < mY && 
					buttonList[i].posY + buttonList[i].buttonHeight > mY)
				{
					if (!buttonList[i].hovering)
					{
						buttonList[i].hover(true);
					}
				}
				else if (buttonList[i].hovering)
				{
					buttonList[i].hover(false);
				}
			}
		}
		
		public function action(g:GuiButton):void
		{
			
		}
		
		public function addButton(g:GuiButton):GuiButton
		{
			buttonList.push(g);
			addChild(g);
			return g;
		}
		
		public function preDestroy():void
		{
			removeEventListener(TouchEvent.TOUCH, onTouch);
			removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		public function destroy():void
		{
		}
		
		protected function onKeyDown(e:KeyboardEvent):void
		{
		}
			
		protected function onKeyUp(e:KeyboardEvent):void
		{
		}
		
		protected function onTouch(e:TouchEvent):void
		{
			var t:Touch = e.getTouch(main);
			
			if (t)
			{
				if (t.phase == TouchPhase.ENDED)
				{
					for (var i:int = buttonList.length - 1; i > -1; i-- )
					{
						if (buttonList[i].posX < mX && 
							buttonList[i].posX + buttonList[i].buttonWidth > mX && 
							buttonList[i].posY < mY && 
							buttonList[i].posY + buttonList[i].buttonHeight > mY)
						{
							buttonList[i].click();
							action(buttonList[i]);
							break;
						}
					}
					
					if (Settings.RANDOM_AXE && randomAxe)
					{
						main.axeLayer.spawn(mX, mY);
					}
				}
			}
		}
	}
}