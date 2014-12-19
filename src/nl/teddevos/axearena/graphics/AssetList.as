package nl.teddevos.axearena.graphics 
{
	import starling.utils.AssetManager;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class AssetList 
	{
		[Embed(source="../../../../../lib/fonts/Rio_Oro.otf", embedAsCFF="false", fontFamily="GameTitleFont")]
		private static const gameTitleFont:Class;
		
		[Embed(source = "../../../../../lib/background/menuBackground.png")]
		private static var image_1:Class;
		
		[Embed(source="../../../../../lib/gui/randomAxe.png")]
		private static var image_2:Class;
		
		[Embed(source="../../../../../lib/background/levelBackground.png")]
		private static var image_3:Class;
		
		[Embed(source = "../../../../../lib/particle/particle_blood.png")]
		private static var image_4:Class;
		
		[Embed(source = "../../../../../lib/gui/gui.png")]
		private static var atlas_1:Class;
		
		[Embed(source = "../../../../../lib/tiles/tiles.png")]
		private static var atlas_2:Class;
		
		[Embed(source="../../../../../lib/projectiles/axes.png")]
		private static var atlas_3:Class;
		
		[Embed(source="../../../../../lib/gui/gui.xml", mimeType="application/octet-stream")]
		private static var xml_1:Class;
		
		[Embed(source="../../../../../lib/tiles/tiles.xml", mimeType="application/octet-stream")]
		private static var xml_2:Class;
		
		[Embed(source="../../../../../lib/projectiles/axes.xml", mimeType="application/octet-stream")]
		private static var xml_3:Class;
		
		public static var assets:AssetManager;
		
		public static var loaded:Boolean = false;
		
		public static function init():void
		{
			assets = new AssetManager();
			assets.verbose = true;
			
			assets.addTexture("background_menu", Texture.fromBitmap(new image_1()));
			assets.addTexture("randomAxe", Texture.fromBitmap(new image_2()));
			assets.addTexture("background_level", Texture.fromBitmap(new image_3()));
			assets.addTexture("particle_blood", Texture.fromBitmap(new image_4()));
			assets.addTextureAtlas("atlas1", new TextureAtlas(Texture.fromBitmap(new atlas_1()), XML(new xml_1())));
			assets.addTextureAtlas("atlas2", new TextureAtlas(Texture.fromBitmap(new atlas_2()), XML(new xml_2())));
			assets.addTextureAtlas("atlas3", new TextureAtlas(Texture.fromBitmap(new atlas_3()), XML(new xml_3())));
			
			assets.loadQueue(
				function(ratio:Number):void 
				{
					if (ratio == 1.0) 
					{
						loaded = true;
					}
				}
			);
		}
	}
}