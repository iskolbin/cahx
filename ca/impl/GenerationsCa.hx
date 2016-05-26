package ca.impl;

import ca.CelluarAutomaton;
import ca.color.Hsv;
import ca.color.Rgb;

class GenerationsCa extends CelluarAutomaton {
	public function new( width: Int, height: Int, colorsCount: Int ) {
		this.colorsCount = colorsCount;
		var colors = new Array<String>();
		for ( i in 0...colorsCount ) {
			var hue = i * Hsv.FULL_CIRCLE/colorsCount;
			colors.push( '#${new Hsv( i * Hsv.FULL_CIRCLE/colorsCount, 1.0, 1.0 ).toRgb().toString()}' );
		}

		super( width, height, colors );
	}

	override function initCell( v: Int, x: Int, y: Int ): Int {
		return Std.random( this.statesCount );
	}

	override function updateCell( v: Int, x: Int, y: Int ): Int {
		return ( this.grid.getNeighborsNeumann( x, y, 1 ).indexOf( (v+1)%this.statesCount ) >= 0 ) ? 
		 	(v+1)%this.statesCount :
		 	v;
	}
}	

