package demo.views.main 
{
	import cocktail.core.gunz.Bullet;
	import cocktail.core.request.Request;

	import demo.AppView;

	/**
	 * @author hems @ henriquematias.com
	 */
	public class RectView extends AppView
	{
		override public function render( request : Request ) : * 
		{
			request;
			
			sprite.graphics.beginFill( 0xccff00 );
			sprite.graphics.drawRect( 0, 0, 500, 500 );
			sprite.graphics.endFill( );
			
			sprite.buttonMode    = true;
			sprite.useHandCursor = true;
			
			delay( 10, call_after_render );
		}

		public function click( bullet : Bullet ) : void
		{
			go( "/main/internal/" );
			
			bullet;
		}
	}
}
