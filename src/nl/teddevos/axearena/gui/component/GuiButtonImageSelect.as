package nl.teddevos.axearena.gui.component 
{
	import starling.textures.Texture;
	
	public class GuiButtonImageSelect extends GuiButtonImage
	{
		public var state:int;
		private var textList:Vector.<String>;
		
		public function GuiButtonImageSelect(id:int, t:Texture, s:String, c:uint, si:int, px:Number, py:Number, start:int, tL:Vector.<String>) 
		{
			super(id, t, s, c, si, px, py, false);
			
			text.text = tL[start];
			state = start;
			textList = tL;
		}
		
		override public function click():void
		{
			state++;
			if (state >= textList.length)
			{
				state = 0;
			}
			text.text = textList[state];
		}
	}
}