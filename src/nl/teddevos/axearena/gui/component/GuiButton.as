package nl.teddevos.axearena.gui.component 
{
	import starling.display.Sprite;

	public class GuiButton extends Sprite
	{
		public var posX:Number;
		public var posY:Number;
		public var buttonWidth:Number;
		public var buttonHeight:Number;
		
		public var buttonID:int;
		public var enabled:Boolean;
		public var hovering:Boolean;
		
		public function GuiButton(id:int, px:Number, py:Number, w:Number, h:Number) 
		{
			posX = px;
			posY = py;
			buttonWidth = w;
			buttonHeight = h;
			
			buttonID = id;
			enabled = true;
			hovering = false;
		}
		
		public function hover(h:Boolean):void
		{
			hovering = h;
		}
		
		public function click():void
		{
			
		}
	}
}