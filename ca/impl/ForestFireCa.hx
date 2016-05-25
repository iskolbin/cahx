package ca.impl;

import ca.CanvasContext;
import ca.CanvasRenderer;
import ca.Grid;
import ca.CelluarAutomaton;

using Lambda;

class ForestFireCa implements CelluarAutomaton {
	var buffer0: Grid<Int>;
	var buffer1: Grid<Int>;
	var grid: Grid<Int>;
	var colors: Array<String>;
	var renderer: CanvasRenderer;
	public var ignitionProbability: Float;
	public var birthProbability: Float;

	public static inline var Free = 0;
	public static inline var Tree = 1;
	public static inline var Fire = 2;

	public function new( width: Int, height: Int, ignitionProbability: Float, birthProbability: Float ) {
		this.buffer0 = new Grid<Int>( width, height, 0 ).map( randomCellStatus );
		this.buffer1 = this.buffer0.copy();
		this.grid = this.buffer0;
		this.ignitionProbability = ignitionProbability;
		this.birthProbability = birthProbability;
		this.renderer = new CanvasRenderer( ['red','green'] );
	}	

	inline function randomCellStatus( v: Int, x: Int, y: Int ): Int {
		return Std.random( 3 );
	}

	inline function isFire( v: Int ) {
		return v == Fire;
	}

	function updateCell( v: Int, x: Int, y: Int ): Int return switch ( v ) {
		case Free: ( Math.random() < this.birthProbability ) ? Tree : Free;
		case Tree: ( Math.random() < this.ignitionProbability || this.grid.getNeighborsNeumann(x,y,1).count( isFire ) > 0 ) ? Fire : Tree;
		case Fire: Free;
		case _: Free;
	}

	public function update() {
		var buffer = (this.grid == this.buffer0) ? this.buffer1 : this.buffer0;
		this.grid = this.grid.map( updateCell, buffer );
	}

	public function render( context: CanvasContext, cellw: Float, cellh: Float ) {

		var renderer = this.renderer;
		var grid = this.grid.grid;
		var width = this.grid.width;
		var height = this.grid.height;

		renderer.clear();
		
		var x = 0;
		var x_ = 0.0;
		while ( x < width ) {
			var y = 0;
			var y_ = 0.0;
			while ( y < height ) {
				switch (grid[x][y]) {
					case 0: 
					case 1: renderer.add( "green", x, y );
					case 2: renderer.add( "red", x, y );
				}
				y += 1;
				y_ += cellh;
			}
			x += 1;
			x_ += cellw;
		}
		
		renderer.render( context, cellh, cellh );
	}
}
