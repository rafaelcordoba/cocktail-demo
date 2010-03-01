package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.gunz.Bullet;
	import cocktail.core.gunz.Gun;
	import cocktail.core.gunz.GunzGroup;
	import cocktail.core.request.Request;
	
	import cocktail.lib.gunz.ViewBullet;
	import cocktail.lib.view.ViewStack;
	import cocktail.utils.Timeout;

	import de.polygonal.ds.DListNode;

	import flash.display.Sprite;

	public class View extends MV 
	{

		/* GUNZ */
		public var gunz_render_done : Gun;

		/* GUNZ */
		public var gunz_destroy_done : Gun;

		/** Contains and indexes all the childs **/
		private var _childs : ViewStack;

		/** The string identifier on parent's ViewStack **/
		public var identifier : String;

		/** The view node on the ViewStack DLinkedList **/
		public var node : DListNode;

		/** Reference to the parent view container **/
		public var up : View;

		/** When created trought xml, this will hold the xml node**/
		private var _xml_node : XML;

		/** Current loading group **/ 
		private var _loading_group : GunzGroup;

		/** View sprite **/
		public var sprite : Sprite;

		private function _init_gunz() : void 
		{
			gunz_render_done = new Gun( gunz, this, "render_done" );
			gunz_destroy_done = new Gun( gunz, this, "destroy_done" );
		}

		/* INITIALIZING */
		
		/**
		 * 
		 */
		override public function boot( cocktail : Cocktail ) : * 
		{
			var s : *;
		
			s = super.boot( cocktail );
			
			_init_gunz( );
			
			_childs = new ViewStack( this );
			_childs.boot( cocktail );
			return s;
		}

		/**
		 * Removes a view from the view stack
		 */
		public function remove( id : String ) : View 
		{
			return childs.remove( id );
		}

		/* LOAD ASSETS */

		/**
		 * Filters the loading action. If return false, load routine will
		 * pause
		 */
		public function before_load( request : Request ) : Boolean 
		{
			log.info( "Running..." );
			
			request;
			return true;
		}

		/**
		 * Load will parse all views, instantiate they, and listen for
		 * all loads to complete. After that, will trigger _after_load_assets
		 */
		public function load( request : Request ) : Boolean 
		{
			if( !before_load( request ) ) return false;

			log.info( "Running..." );
			
			var i : int;
			var assets : Array;
			var view : View;
			
			childs.clear_render_poll( );
			
			if( !( assets = _parse_assets( request ) ).length )
			{
				var bullet : ViewBullet;
				
				bullet = new ViewBullet( );
				bullet.params = request;
				
				new Timeout( _after_load_assets, 1, bullet );
			}
			else
			{
				_loading_group = new GunzGroup( );
				_loading_group.gunz_complete.add( _after_load_assets, request );

				//TODO: use a lambda to run all selected assets				
				do 
				{
					view = assets[ i ];
					_loading_group.add( view.gunz_load_complete );
				} while( ++i < assets.length );
				
				
				i = 0; 
				do 
				{
					view = assets[ i ];
					view.load( request );
					childs.mark_as_alive( view );
				} while( ++i < assets.length );
			}
			
			return true;
		}

		/**
		 * Parses all necessary Datasources for given Process.
		 * @param process	Running process.
		 * @return	An array with all Datasources, properly instantiated. 
		 */
		private function _parse_assets( request : Request ) : Array 
		{
			log.info( "Running..." );
			var i : int;
			var assets : Array;
			var list : XMLList;
			var node : XML;
			var action : String;
			
			action = request.route.api.action;
			assets = [];
			
			//layout will work just if it finds 1 action.
			if( this is Layout )
			{
				list = _scheme..action.( @id == action || @id == "*" );
				
				xml_node = XML( list.toXMLString( ) );
			}
			
			list = xml_node.children( );
			
			if( !list || !list.length( ) ) return assets;
			
			do
			{
				node = list[i];
					
				assets.push( _instantiate_view( node ) );
			} while( ++i < list.length( ) );
			
			
			return assets;
		}

		/**
		 * Triggered after all views have loaded its content
		 */
		private function _after_load_assets( bullet : Bullet ) : void 
		{
			log.info( "Running..." );
			bullet;
			gunz_load_complete.shoot( new ViewBullet( ) );
		}

		/**
		 * Instantiate a view based on a xml_node, if it already exists, 
		 * will just return the reference.
		 */
		internal function _instantiate_view( xml_node : XML ) : View 
		{
			var view : View;
			
			if( !xml_node.hasOwnProperty( 'id' ) && false )
			{
				log.warn( "Your view needs to have and id" );
				//FIXME: this ['id'] is becoming a child, not a prop
				xml_node[ 'id' ] = Math.random( ) * 100000000000;
				log.warn( "Assigned a random id: " + xml_node[ 'id' ] );
			}
			
			if( ( view = childs.by_id( xml_node.attribute( 'id' ) ) ) != null ) 
			{
				childs.mark_as_alive( view );
				return childs.by_id( xml_node.attribute( 'id' ) );
			}
			
			return childs.create( xml_node );
		}

		private function before_render( request : Request ) : Boolean 
		{
			log.info( "Running..." );
			request;
			return true;
		}

		public function render( request : Request ) : Boolean
		{
			if( !before_render( request ) ) return false;
			
			log.info( "Running..." );
			
			if( !sprite )
			{
				sprite = new Sprite( );
				
				if( this is Layout )
				{
					Layout( this ).target.addChild( sprite );
				}
				else
					up.add( this );
			}
			
			childs.render( request );
			
			after_render( request );
			
			return true;
		}

		private function add( view : View ) : void 
		{
			sprite.addChild( view.sprite );
		}

		public function after_render( request : Request ) : void
		{
			log.info( "Running..." );
			request;
		}

		/**
		 * Destroy filter, if returns false, wont destroy
		 */
		public function before_destroy( request : Request ) : Boolean
		{
			log.info( "Running..." );
			request;
			return true;
		}

		public function destroy( request : Request ) : Boolean 
		{
			if( !before_destroy( request ) ) return false;
			
			log.info( "Running..." );
			
			return true;
		}

		public function after_destroy( request : Request ) : void 
		{
			log.info( "Running..." );
			request;
		}

		/** GETTERS / SETTERS **/

		public function get xml_node() : XML  
		{
			return _xml_node;
		}

		public function set xml_node( xml_node : XML ) : void 
		{
			_xml_node = xml_node;
		}

		public function get root() : Layout 
		{
			return ( up == null ) ? Layout( this ) : up.root;
		}

		public function get childs() : ViewStack
		{
			return _childs;
		}
	}
}