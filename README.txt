================================================================================
ABOUT
================================================================================

This is an Application Demo using the Cocktail Framework. It's under development
together the framework itself, so stay up to date.

See also the cocktail repo:
	http://github.com/nybras/cocktail/


================================================================================
VERSION
================================================================================

- 2010/03/06 - 0.1 Unstable


================================================================================
DOWNLOADING A PROJECT
================================================================================


1.	Clone the repository
		$ git clone http://github.com/[your-username]/cocktail-demo

2.	If you just want to run/edit the DEMO application, SKIP this step.
	If you want to contribute/edit core cocktail OR shake, you should: 

		# this will point submodules to your repos
		$ cd cocktail-demo/
		
		$ git config submodule.cocktail.url git@github.com:[your-username]/cocktail.git
		
		# if you dont want to edit shake, skip this
		$ git config submodule.shake.url git@github.com:[your-username]/shake.git


3.	Initialize and update the submodules ( cocktail / shake )
		$ cd cocktail-demo/
		$ git submodule init
		$ git submoule update


================================================================================
RUNNING
================================================================================

This six steps will guide you to get this application compiling and working.

This way you will be able to test your application inside the browser, which
is a pretty useful thing to do.

For those using FDT, use the "Import Project" in Eclipse to import this project.
You'll automagically get everything working for you. You'll only need to do the
fifth step, and so you can try the included Debug Launch Configuration:
	
	Debug -> cocktail-demo-core

In case something don't work for you, feel free to use the MailingLists listed
below. Surely somebody will help you with this.


--------------------------------------------------------------------------------
1.	Add these paths to your classpath:
		/src/
		/cocktail/src/
		/cocktail/src/cocktail/vendors/src/

--------------------------------------------------------------------------------
2.	Add these swc to your classpath:
		/cocktail/src/cocktail/vendors/swc/e4xparser.swc
		/cocktail/src/cocktail/vendors/swc/swfaddress.swc

--------------------------------------------------------------------------------
3.	You have to configure a pre-compile action to automagically generate the
	Embedder class, used by Cocktail. You can do it in two ways:

		3.a)
			Using ANT. There's a build.xml file inside the /configs/ant/ folder.
		
		3.b)
			Executing the demo/shake/shake.rb file with the "embedder" argument:
		
				ruby shake/shake.rb embedder

--------------------------------------------------------------------------------
4. Compile the
		/src/CocktaiDemo.as class
	to the
		/www/cocktail/swf/core.swf
	file.

--------------------------------------------------------------------------------
5.	Create a symbolic link between your WebServer folder and the
		/www/
	folder. If you're in Linux or OSX, it'll be something like this:
	
		ln -s /{absolute-path}/cocktail-demo/www/ www/cocktail-demo

--------------------------------------------------------------------------------
6.	Launch the url:
		http://localhost/cocktail-demo/


================================================================================
SYSTEM REQUIREMENTS
================================================================================

1. You will need an WebServer with PHP support, for phpamf test examples.
If you don't want to, just comment the amf datasource in the this xml:
	/www/cocktail/xml/models/main.xml

2. You will also need Ruby in your machine in order to use Shake, the Cocktail
Scaffolding engine. See more at:
	http://github.com/nybras/shake/


================================================================================
BUG REPORTS
================================================================================

http://assembla.com/spaces/cocktail/tickets/


================================================================================
MAILING LISTS
================================================================================

Users talk:
	http://groups.google.com/group/cocktail-en/

Developers talk:
	http://groups.google.com/group/cocktail-dev/
	
	
