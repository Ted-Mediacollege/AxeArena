package nl.teddevos.axearena 
{
	import flash.display.Sprite;
	import starling.core.Starling;
	import nl.teddevos.axearena.data.Settings;
	
	public class PreLoader extends Sprite 
	{
		public var starling:Starling;
		public static var preloader:PreLoader;
		
		public function PreLoader() 
		{
			starling = new Starling(Main, stage);
			starling.showStats = Settings.DEBUG;
			starling.start();
			
			preloader = this;
		}
	}
}