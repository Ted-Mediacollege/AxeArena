package nl.teddevos.axearena.world 
{
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import nl.teddevos.axearena.graphics.AssetList;
	
	public class WorldBackground extends Sprite
	{
		private var quadbatch:QuadBatch;
		
		public function WorldBackground(level:Vector.<int>) 
		{
			quadbatch = new QuadBatch();
			addChild(quadbatch);
			
			var tiles:Vector.<Texture> = AssetList.assets.getTextures("tile_0");
			var img:Image;
			var id:int = 0;
			
			for (var i:int = 0; i < 20; i++ )
			{
				for (var j:int = 0; j < 12; j++ )
				{
					id = level[j * 20 + i];
					if (id > 0)
					{
						img = new Image(tiles[id]);
						img.x = i * 64;
						img.y = j * 64;
						quadbatch.addImage(img);
					}
				}
			}
		}	
	}
}