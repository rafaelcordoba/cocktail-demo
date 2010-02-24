package cocktail.lib 
{
	import cocktail.core.gunz.GunzGroup;
	import cocktail.core.request.Request;
	import cocktail.core.slave.gunz.SlaveBullet;
	import cocktail.core.slave.slaves.TextSlave;
	import cocktail.lib.base.MVL;
	import cocktail.lib.gunz.ModelBullet;
	import cocktail.lib.model.datasources.ADataSource;

	/**
	 * @author hems
	 * @author nybras
	 */
	public class Model extends MVL
	{
		/* LOADING */
		
		/**
		 * Filtering load action, if returns false, no load will occur
		 */
		public function before_load() : Boolean
		{
			log.info( "Running..." );
			return true;
		}

		/* LOADING, VALIDATING AND PARSING SCHEME */
		
		/**
		 * Load model scheme.
		 * @param process	Running process.
		 */
		public function load_scheme( process : Request ) : Model
		{
			process;
			log.info( "Running..." );
			gunz_scheme_load_start.shoot( new ModelBullet( ) );
			load_uri( _xml_path ).gunz_complete.add( _after_load_scheme );
			return this;
		}

		/**
		 * Parsing model xml scheme.
		 * @param bullet	SlaveBullet.
		 */
		public function _after_load_scheme( bullet : SlaveBullet ) : void
		{
			log.info( "Running..." );
			
			_scheme = new XML( TextSlave( bullet.owner ).data );
			if( !_is_scheme_valid )
				log.fatal( "The scheme in this file has errors." + _xml_path );
			else
				gunz_scheme_load_complete.shoot( new ModelBullet( ) );
		}

		/**
		 * Checks if the scheme is valid.
		 * @return	If shceme is valid, returns <code>true</code> otherwise
		 * return <code>false</code>.
		 */
		private function get _is_scheme_valid() : Boolean
		{
			log.info( "Running..." );
			// TODO: scheme needs to be validated against any inconsistence or
			//  problem cause that may exists
			return true;
		}

		/* LOADING DATA */

		/**
		 * Load all datasources needed for the request.
		 * @param process	Running process.
		 */
		public function load_data( process : Request ) : Model
		{
			log.info( "Running..." );
			var i : int;
			var group : GunzGroup;
			var ds_list : Array;
			var ds : ADataSource;
			
			if( ( ds_list = _parse_datasources( process ) ).length )
			{
				group = new GunzGroup( );
				do
				{
					ds = ds_list[ i ];
					group.add( ds.gunz_load_complete );
					ds.load( );
				} while( i++ < ds_list.length );
			}
			
			return this;
		}

		/**
		 * Parses all necessary Datasources for given Process.
		 * @param process	Running process.
		 * @return	An array with all Datasources, properly instantiated. 
		 */
		private function _parse_datasources( process : Request ) : Array
		{
			log.info( "Running..." );
			var i : int;
			var ds : Array;
			var node : XML;
			var action : String;
			var inject : String;
			
			ds = []; 
			action = process.route.api.action;
			
			do
			{
				node = _scheme.children( )[ i ];
				inject = node.inject.@actions;
				if( inject == "*" || inject.indexOf( action ) > 0 )
					ds.push( _instantiate_datasource( node ) );
			} while( i++ > _scheme.length( ) );
			
			return ds;
		}

		/**
		 * Instantiate the DataSource based on the given xml node.
		 * @param node	XML Scheme representation of the Datasource to be
		 * instantiated.
		 */
		private function _instantiate_datasource( node : XML ) : ADataSource
		{
			log.info( "Running..." );
			var ds : ADataSource;
			
			ds = new ( _cocktail.factory.datasource( node.@type ) )( );
			ds.boot( _cocktail );
			
			return ds;
		}

		/* GETTERS */

		/**
		 * Evaluates the path for the xml file.
		 * @return	The path to the xml file.
		 */
		private function get _xml_path() : String
		{
			log.info( "Running..." );
			var path : String;
			
			path = config.path( ".xml" ) + "models/";
			path += classname.toLowerCase( ).replace( "model", "" ) + ".xml";
			
			return path;
		}
	}
}