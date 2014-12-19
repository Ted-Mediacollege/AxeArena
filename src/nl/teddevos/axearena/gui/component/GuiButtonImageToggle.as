package nl.teddevos.axearena.gui.component 
{
	import starling.textures.Texture;
	
	public class GuiButtonImageToggle extends GuiButtonImage
	{
		public var state:Boolean;
		private var trueString:String;
		private var falseString:String;
		
		public function GuiButtonImageToggle(id:int, t:Texture, s:String, c:uint, si:int, px:Number, py:Number, startState:Boolean, sT:String, sF:String) 
		{
			super(id, t, s, c, si, px, py, false);
			state = startState;
			text.text = startState ? sT : sF;
			
			trueString = sT;
			falseString = sF;
		}
		
		override public function click():void
		{
			state = !state;
			text.text = state ? trueString : falseString;
		}
	}
}