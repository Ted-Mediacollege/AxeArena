package nl.teddevos.axearena.gui 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import nl.teddevos.axearena.graphics.AssetList;
	
	public class GuiAxeLayer extends Sprite
	{
		public var axes:Vector.<GuiAxe>;
		public var texture:Texture;
		
		public function GuiAxeLayer() 
		{
			texture = AssetList.assets.getTexture("randomAxe");
			axes = new Vector.<GuiAxe>();
		}
		
		public function spawn(targetX:Number, targetY:Number):void
		{
			var axe:GuiAxe = new GuiAxe(texture, targetX, targetY);
			axes.push(axe);
			addChild(axe);
		}
		
		public function tick():void
		{
			var axe:GuiAxe;
			var l:int = axes.length;
			
			for (var i:int = l - 1; i > -1; i-- )
			{
				axe = axes[i];
				if (axe.posY > 850)
				{
					removeChild(axe);
					axes.splice(i, 1);
				}
				else
				{
					axe.posX += axe.velX * 22;
					axe.posY += axe.velY * 22;
					axe.x = axe.posX;
					axe.y = axe.posY;
					axe.rotation += 0.4;
					
					if (axe.targetReached)
					{
						axe.velY += 0.05;
					}
					else
					{
						if ((Math.abs(axe.posX - axe.targetX) + Math.abs(axe.posY - axe.targetY)) < 30)
						{
							axe.targetReached = true;
						}
					}
				}
			}
		}
	}
}