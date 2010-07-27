package demo.boot 
{
	import cocktail.core.boot.BootTail;

	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author nybras | nybras@codeine.it
	 */
	public class Boot extends BootTail 
	{
		override protected function _load() : void 
		{
			super._load();
			
			_add_disclaimer();	
		}
		
		private function _add_disclaimer() : void 
		{
			var info: TextField;
			
			info = new TextField();
			info.text = 'loading data... please wait.';
			info.setTextFormat( new TextFormat( 'Arial', 12, '#FFF' ) );
			addChild( info );
		}
	}
}
