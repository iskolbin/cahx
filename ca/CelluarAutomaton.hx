package ca;

class CelluarAutomaton {
	public var gridBuffer0(default,null): Grid<Int>;
	public var gridBuffer1(default,null): Grid<Int>;
	public var grid(default,null): Grid<Int>;
	public var renderBuffer(default,null): RenderBuffer;
	public var width(get,null): Int;
	public var height(get,null): Int;
	public var statesCount(default,null): Int;
	public var dirty = true;

	public inline function get_width() return grid.width;
	public inline function get_height() return grid.height;

	function initCell( v: Int, x: Int, y: Int ) {
		return 0;
	}

	function updateCell( v: Int, x: Int, y: Int ) {
		return v;
	}

	public function new( width: Int, height: Int, colors: Array<String> ) {
		this.renderBuffer = new RenderBuffer( colors );
		this.gridBuffer0 = new Grid<Int>( width, height );
		this.gridBuffer0.map( initCell, this.gridBuffer0 );
		this.gridBuffer1 = this.gridBuffer0.copy();
		this.grid = this.gridBuffer0;
		this.statesCount = colors.length;
	}

	public function update(): Void {
		var gridPrev = this.grid.grid;
		var gridNext = nextGridBuffer().grid;
		var width = this.width;
		var height = this.height;

		for ( x in 0...width ) {
			for ( y in 0...height ) {
				var newc = updateCell( gridPrev[x][y], x, y );
				gridNext[x][y] = newc;
			}
		}
		
		swapGridBuffers();
		
		dirty = true;
	}

	inline function nextGridBuffer() {
		return (this.grid == this.gridBuffer0) ? this.gridBuffer1 : this.gridBuffer0;
	}

	inline function swapGridBuffers() {
		var gridBuffer = nextGridBuffer();
		this.grid = gridBuffer;
	}

	inline function updateRenderBuffer() {
		if ( dirty ) {
			var grid = this.grid.grid;
			var width = this.width;
			var height = this.height;

			renderBuffer.clear();
			for ( x in 0...width ) {
				for ( y in 0...height ) {
					renderBuffer.add( grid[x][y], x, y );
				}
			}

			dirty = false;
		}
	}
		
	public function render( renderer: Renderer, cellw: Int, cellh: Int, screenw: Int, screenh: Int ): Void {
		updateRenderBuffer();
		renderer.clear( screenw, screenh );
		renderer.render( renderBuffer, cellw, cellh );	
	}

	public static inline var NEXT = -1;
	public static inline var PREV = -2;

	public function setCell( x: Int, y: Int, value: Int ) {
		var grid = this.grid.grid;
		var nextvalue = if ( value == NEXT ) {
			(grid[x][y] + 1) % this.statesCount;
		} else if ( value == PREV ) {
			(grid[x][y] - 1) % this.statesCount;
		} else {
			(value) % this.statesCount;
		}

		if ( nextvalue != grid[x][y] ) {
			grid[x][y] = nextvalue;
			dirty = true;
		}
	}	
}
