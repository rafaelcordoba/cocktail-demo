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
			
			for( var i : int = 0; i < 20; i++ ) 
			{
				delay( i * .05, _step_motion , i );
			}
		}

		private function _step_motion( i : Number ) : void 
		{
			sprite.alpha = .1 * i;
			sprite.x += 2;
		}
	}
}
