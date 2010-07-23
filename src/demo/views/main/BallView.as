package demo.views.main 
{
	import cocktail.core.request.Request;

	import demo.AppView;

	/**
	 * @author hems @ henriquematias.com
	 */
	public class BallView extends AppView 
	{

		override public function render( request : Request ) : * 
		{
			request;
			log.info( "Running..." );
			
			sprite.graphics.beginFill( 0xFF0000 );
			sprite.graphics.drawCircle( 0, 0, 50 );
			sprite.graphics.endFill( );
			
			sprite.alpha = 0;
			
			for( var i : int = 0; i < 10; i++ ) 
			{
				delay( i * .1, function( k: Number ): void
				{
					sprite.alpha = k * .1;
				}, i );
			}
		}
	}
}
