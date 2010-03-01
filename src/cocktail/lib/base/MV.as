package cocktail.lib.base 
{
	import cocktail.Cocktail;
	import cocktail.core.gunz.Gun;
	import cocktail.core.slave.ASlave;
	import cocktail.core.slave.ISlave;
	import cocktail.core.slave.Slave;
	import cocktail.core.slave.slaves.GraphSlave;
	import cocktail.core.slave.slaves.TextSlave;
	import cocktail.lib.Controller;

	/**
	 * Contains some preloading proxy utils for Model, Layout and View, and
	 * some another core functionality usefull only for these classes.
	 */
	public class MV extends MVC
	{
		/* GUNZ */
		public var gunz_scheme_load_start : Gun; 

		public var gunz_scheme_load_complete : Gun; 

		private function _init_gunz() : void
		{
			gunz_scheme_load_start = new Gun( gunz, this, "load_start" );
			gunz_scheme_load_complete = new Gun( gunz, this, "load_complete" );
		}

		/* BOOTING */
		override public function boot( cocktail : Cocktail ) : *
		{
			var s : *;
			
			s = super.boot( cocktail );
			
			_init_gunz( );
			
			return s;
		}

		/* VARS */
		internal var _controller : Controller;  
		
		/** XML Scheme for Model, View and Layout. */
		protected var _scheme : XML;

		/** Queue holders for loading shorcuts. */
		private var _load_queue : Slave;

		/** Quite explainatory name, huh? **/
		private var _is_queue_opened : Boolean;

		/**
		 * 
		 */
		public function load_queue( opening : Boolean = false ) : Slave
		{
			if( opening )
			{
				_is_queue_opened = true;
				return ( _load_queue = new Slave( false ) );
			}
			else
				_is_queue_opened = false;
			
			return Slave( _load_queue.load( ) );
		}

		/**
		 * 
		 */
		public function load_uri( uri : String ) : ASlave
		{
			return null;
//			var slave : ASlave;
//			
//			switch( uri.toLowerCase( ).split( "." ).pop( ) )
//			{
//				case "jpg": 
//					slave = new GraphSlave( uri, _is_queue_opened );
//				case "jpeg": 
//					slave = new GraphSlave( uri, _is_queue_opened );
//				case "png": 
//					slave = new GraphSlave( uri, _is_queue_opened );
//				case "gif": 
//					slave = new GraphSlave( uri, _is_queue_opened );
//				case "swf": 
//					slave = new GraphSlave( uri, _is_queue_opened );
//				case "xml": 
//					slave = new TextSlave( uri, _is_queue_opened );
//			}
//			
//			if( _is_queue_opened )
//				_load_queue.append( slave );
//			else
//				ISlave( slave ).load( );
//			
//			return slave;
		}

		/**
		 * Returns a controller instance by name 
		 * ( unique per cocktail instance )
		 */
		public function controller( name : String ) : Controller
		{
			return _cocktail.process.controller( name );
		}
	}
}
