//declaring javascript methods
//this way would be easier to read the code

cocktail = { 
	path: '', //path to the base cocktail folder
	config: {} //basic app info for embedding
};
cocktail.js      = {};
cocktail.swf     = {};
cocktail.browser = { 
	scroll: {} //scrollbar related methods
} ;

/**
 * Save cocktail path, and require javascript dependences
 */
cocktail.boot = function( path )
{
	this.path = path;
}

cocktail.auto_size = function()
{
	$( window ).resize(function() 
	{
		if( $( window ).width() < cocktail.config.min.width )
			$( cocktail.config.name ).css( 'width', cocktail.config.min.width );
		else
			$( cocktail.config.name ).css( 'width', cocktail.config.width );

		if( $( window ).height() < cocktail.config.min.height )
			$( cocktail.config.name ).css( 'height', cocktail.config.min.height );
		else
			$( cocktail.config.name ).css( 'height', cocktail.config.height );
	});
}

/**
 * Create a swf object for the cocktail boot file
 */
cocktail.embed = function( container, config, flashvars, params, attributes )
{
	this.config = config;
	
	swfobject.embedSWF(
		cocktail.swf.path( 'boot.swf' ), 
		container, 
		config.width,
		config.height,
		config.player_version,
		cocktail.swf.path( 'expressinstall.swf' ), 
		flashvars, 
		params, 
		attributes
	);
	
	if( config.min.width || config.min.height ) cocktail.auto_size();
}

/**
 * Use document.write to add a javascript to the page
 */
cocktail.js.write = function( path )
{
	var tag;
	
	tag = '<script type="text/javascript" src="' + path + '"></script>';
	
	document.write( tag );
}

/**
 * Embed all needed javascript files
 */
cocktail.js.embed = function()
{
	var path;
	
	path = cocktail.path + '/js';
	
	cocktail.js.write( path + '/swfobject/swfobject.js' );
	cocktail.js.write( path + '/jquery/jquery-1.4.2.min' );
	cocktail.js.write( path + '/swfaddress/swfaddress.js' );
	cocktail.js.write( path + '/mousewheel/extMouseWheel.js' );
}

/**
 * Requests and runs ( evil! ) javascript in runtime
 */
cocktail.js.request = function( filename )
{
	var head_element;
	var js;

	head_element = document.getElementsByTagName( 'head' ).item( 0 );

	js = document.createElement( 'script' );
	js.setAttribute( 'language', 'javascript' );
	js.setAttribute( 'type', 'text/javascript' );
	js.setAttribute( 'src', filename );
	
	head_element.appendChild( js );
}


/**
 * @param flash_id
 *            The id used to embed the swf
 * 
 * @return reference to the desired swf
 */
cocktail.swf.get = function( flash_id )
{
	if ( navigator.appName.indexOf( "Microsoft" ) != -1 )
	{
		return window[ flash_id ];
	} else
	{
		return document[ flash_id ];
	}
}

/**
 * @return
 * 			path to the swf in this cocktail instance
 */
cocktail.swf.path = function( swf_file )
{
	return cocktail.path + '/swf' + swf_file;
}



/** browser api * */



/**
 * This function will broadcast browser scroll position to cocktail.
 * 
 * This will be handled by the Browser api
 * 
 * 
 * @param flash_id
 *            The id used to embed the target swf
 */
cocktail.browser.scroll.active = function( flash_id )
{
	$( document ).ready( function()
		{
			$( window ).scroll( function( event )
				{
					if ( !this.swf( flash_id )._set_browser_scroll )
						return;

					cocktail.swf( flash_id )._set_browser_scroll(
						$( 'body' ).scrollLeft(),
						$( 'body' ).scrollTop() 
					);
				} );
		} );
}

/**
 * This will slide browser scroll to the desired position
 * 
 * 
 * @param x
 *            Horizontal position in pixels
 * 
 * @param y
 *            Vertical position in pixels
 */
cocktail.browser.scroll.slide = function( x, y )
{
	var props;

	props = { easing : 'easeOutExpo' };

	if ( x )
		props.scrollLeft = x;

	if ( y )
		props.scrollTop = y;

	$( 'html,body' ).animate( props, 500 );
}

//alert( "cocktail js loaded" );