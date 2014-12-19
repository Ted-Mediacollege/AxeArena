package nl.teddevos.axearena.gui.component 
{
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class GuiButtonImage extends GuiButton
	{
		public var text:TextField;
		public var img:Image;
		private var textSize:int;
		private var hoverable:Boolean;
		
		public function GuiButtonImage(id:int, t:Texture, s:String, c:uint, si:int, px:Number, py:Number, h:Boolean = true) 
		{
			super(id, px, py, t.nativeWidth, t.nativeHeight);
			hoverable = h;
			
			img = new Image(t);
			img.x = px;
			img.y = py;
			addChild(img);
			
			text = new TextField(t.nativeWidth, t.nativeHeight, s, "GameTitleFont", si, c);
			text.x = px;
			text.y = py;
			addChild(text);
			textSize = si;
		}
		
		override public function hover(h:Boolean):void
		{
			if (hoverable)
			{
				hovering = h;
				if (hovering)
				{
					img.x -= 20;
					img.y -= 5;
					img.scaleX = 1 + (1 / (img.width / 40));
					img.scaleY = 1 + (1 / (img.width / 80));
					text.fontSize = textSize * img.scaleX;
				}
				else
				{
					img.x += 20;
					img.y += 5;
					img.scaleX = 1;
					img.scaleY = 1;
					text.fontSize = textSize;
				}
			}
		}
		
		override public function click():void
		{
			
		}
	}
}