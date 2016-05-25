package ca.impl;

import ca.CanvasContext;
import ca.CanvasRenderer;
import ca.Grid;
import ca.CelluarAutomaton;

class GenerationsCa implements CelluarAutomaton {
	var buffer0: Grid<Int>;
	var buffer1: Grid<Int>;
	var grid: Grid<Int>;
	var colors: Array<String>;
	var renderer: CanvasRenderer;

	inline function randomColor( v: Int, x: Int, y: Int ): Int {
		return Std.random( this.colors.length );
	}

	public function new( width: Int, height: Int, colors: Array<String> ) {
		this.colors = colors;
		this.buffer0 = new Grid( width, height, 0 ).map( randomColor );
		this.buffer1 = this.buffer0.copy();
		this.grid = this.buffer0;
		this.renderer = new CanvasRenderer( colors );
	}

	function nextGen( v: Int, x: Int, y: Int ): Int {
		var len = colors.length;
		return ( this.grid.getNeighborsNeumann( x, y, 1 ).indexOf( (v+1)%len ) >= 0 ) ? 
		 	(v+1)%len :
		 	v;
	}

	public function update() {
		var buffer = (this.grid == this.buffer0) ? this.buffer1 : this.buffer0;
		var len = this.colors.length;
		this.grid = this.grid.map( nextGen, buffer );
	}

	public function render( context: CanvasContext, cellw: Float, cellh: Float ) {
		var renderer = this.renderer;
		var grid = this.grid.grid;
		var width = this.grid.width;
		var height = this.grid.height;
		var colors = this.colors;

		renderer.clear();
		
		var x = 0;
		var x_ = 0.0;
		while ( x < width ) {
			var y = 0;
			var y_ = 0.0;
			while ( y < height ) {
				renderer.add( colors[grid[x][y]], x, y );
				y += 1;
				y_ += cellh;
			}
			x += 1;
			x_ += cellw;
		}

		renderer.render( context, cellh, cellh );
	}
}	

