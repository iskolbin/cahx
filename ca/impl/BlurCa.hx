package ca.impl;

import ca.CelluarAutomaton;
import ca.color.Hsv;
import ca.color.Rgb;

class BlurCa extends CelluarAutomaton {
	public function new( width: Int, height: Int, maxPower: Int ) { 
		var colors = new Array<String>();
		for ( i in 0...maxPower ) {
			var power = i / (maxPower-1);
			colors.push( '#${new Hsv( 0.0, 1.0, power ).toRgb().toString()}' );
		}

		super( width, height, colors );
	}
	
	override function initCell( v: Int, x: Int, y: Int ): Int {
		return Std.random( this.statesCount );
	}

	override function updateCell( v: Int, x: Int, y: Int ): Int {
		var power = v;
		for ( v_ in this.grid.getNeighborsNeumann( x, y, 1 )) {
			power += v_;
		}
		return Std.int(power/5);
	}
}	
