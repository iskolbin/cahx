package ca.impl;

import ca.CelluarAutomaton;

class FallingSandCa extends CelluarAutomaton {

	public function new( width: Int, height: Int ) {
		super( width, height, ["", "white"] );
	}
	
	override function updateCell( v: Int, x: Int, y: Int ): Int {
		if ( v == 0 ) {
			if ( y > 0 && grid.get(x,y-1) == 1 ) {
				return 1;
			} else {
				return 0;
			}
		} else {
			if ( y+1 < height && grid.get(x,y+1) == 0 ) {
				return 0;
			} else {
				return 1;
			}
		}
	}
}
