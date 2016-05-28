package ca.impl;

import ca.CelluarAutomaton;
import ca.color.Hsv;
import ca.color.Rgb;

class ThermodynamicsCa extends CelluarAutomaton {
	public var conductivity: Int;

	public function new( width: Int, height: Int, maxPower: Int ) { 
		var colors = new Array<String>();
		for ( i in 0...maxPower ) {
			var power = i / (maxPower-1);
			var value = Math.min( 1.0, power * 2 );
			var hue = ( i < maxPower/2 ) ? 0.0 : ((i-Std.int(maxPower/2))/(maxPower/2))*Hsv.ONE_SIXTH_CIRCLE;
			colors.push( '#${new Hsv( hue, 1.0, power ).toRgb().toString()}' );
		}

		super( width, height, colors );
	}
	
	override function initCell( v: Int, x: Int, y: Int ): Int {
		return Std.random( this.statesCount );
	}

	override function updateCell( v: Int, x: Int, y: Int ): Int {
		var power = v;
		for ( v_ in this.grid.getNeighborsNeumann( x, y, 1 )) {
			if ( v_ >= v ) {
				power += 1;
			} else if ( v_ <= v ) {
				power -= 1;
			}
		}
		return power > 0 ? power : 0;
	}
}	

