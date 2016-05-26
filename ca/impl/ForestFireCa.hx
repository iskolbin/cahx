package ca.impl;

import ca.CelluarAutomaton;

using Lambda;

class ForestFireCa extends CelluarAutomaton {
	public var ignitionProbability: Float;
	public var birthProbability: Float;

	public static inline var Free = 0;
	public static inline var Tree = 1;
	public static inline var Fire = 2;

	public function new( width: Int, height: Int, ignitionProbability: Float, birthProbability: Float ) {
		super( width, height, ["", "green", "red"] );
		this.ignitionProbability = ignitionProbability;
		this.birthProbability = birthProbability;
	}	

	override function initCell( v: Int, x: Int, y: Int ): Int {
		return Std.random( 3 );
	}

	inline function isFire( v: Int ) {
		return v == Fire;
	}

	override function updateCell( v: Int, x: Int, y: Int ): Int return switch ( v ) {
		case Free: ( Math.random() < this.birthProbability ) ? Tree : Free;
		case Tree: ( Math.random() < this.ignitionProbability || this.grid.getNeighborsNeumann(x,y,1).count( isFire ) > 0 ) ? Fire : Tree;
		case Fire: Free;
		case _: Free;
	}
}
