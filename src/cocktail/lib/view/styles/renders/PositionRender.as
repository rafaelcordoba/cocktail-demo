/*	****************************************************************************
		Cocktail ActionScript Full Stack Framework. Copyright (C) 2009 Codeine.
	****************************************************************************
   
		This library is free software; you can redistribute it and/or modify
	it under the terms of the GNU Lesser General Public License as published
	by the Free Software Foundation; either version 2.1 of the License, or
	(at your option) any later version.
		
		This library is distributed in the hope that it will be useful, but
	WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
	or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
	License for more details.

		You should have received a copy of the GNU Lesser General Public License
	along with this library; if not, write to the Free Software Foundation,
	Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

	-------------------------
		Codeine
		http://codeine.it
		contact@codeine.it
	-------------------------
	
*******************************************************************************/

package cocktail.lib.view.styles.renders 
{
	import cocktail.lib.view.styles.renders.Render;
	import cocktail.lib.view.styles.selectors.PositionSelector;	
	
	/**
	 * Render all Position properties
	 * @author nybras | nybras@codeine.it
	 */
	public class PositionRender extends Render 
	{
		/* ---------------------------------------------------------------------
			RENDER
		--------------------------------------------------------------------- */
		
		/**
		 * Start the automagic live rendering. 
		 */
		public function render () : void
		{
			_style.plug( PositionSelector.LEFT, _left );
			_style.plug( PositionSelector.TOP, _top );
			_style.plug( PositionSelector.RIGHT, _right );
			_style.plug( PositionSelector.BOTTOM, _bottom );
			_style.plug( PositionSelector.ALIGN, _align );
			_style.plug( PositionSelector.OVERFLOW, _overflow );
			_style.plug( PositionSelector.OVERFLOW_X, _overflow_x );
			_style.plug( PositionSelector.OVERFLOW_Y, _overflow_y );
			_style.plug( PositionSelector.Z_INDEX, _z_index );
		}
		
		
		
		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _left( value : * ) : void
		{
			// TODO: implement "position" (absolute, relative etc) flags
			if ( _is_percent( value ) )
				_target.x = ( _target.parent.width * u ( _clear_unit ( value ) ) );
			else
				_target.x = u ( _clear_unit ( value ) );
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _top( value : * ) : void
		{
			// TODO: implement "position" (absolute, relative etc) flags
			if ( _is_percent( value ) )
				_target.y = ( _target.parent.height * u ( _clear_unit ( value ) ) );
			else
				_target.y = u ( _clear_unit ( value ) );
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _right( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _bottom( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _align( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _overflow( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _overflow_x( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _overflow_y( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _z_index( value : * ) : void
		{
			// TODO: implement method
		}
	}
}