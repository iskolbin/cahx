package ca.impl;

import ca.CelluarAutomaton;

using Lambda;

class GameOfLifeCa extends CelluarAutomaton {
	public var density(default,null): Float;

	public function new( width: Int, height: Int, density: Float = 0.5 ) {
		this.density = density;

		super( width, height, ["", "white"] );
	}

	override function initCell( v: Int, x: Int, y: Int ): Int {
		return (Math.random() < this.density) ? 1 : 0;
	}

	inline function isOne( v: Int ) {
		return v == 1;
	}

	override function updateCell( v: Int, x: Int, y: Int ): Int {
		var count = this.grid.getNeighborsMoore( x, y, 1 ).count( isOne );
		return (( v == 0 && count == 3 ) || ( v == 1 && (count == 2 || count == 3))) ? 1 : 0; 
	}
}	

