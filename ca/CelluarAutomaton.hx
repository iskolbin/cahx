package ca;

class CelluarAutomaton {
	public var gridBuffer0(default,null): Grid<Int>;
	public var gridBuffer1(default,null): Grid<Int>;
	public var grid(default,null): Grid<Int>;
	public var renderBuffer(default,null): RenderBuffer;
	public var width(get,null): Int;
	public var height(get,null): Int;

	public inline function get_width() return grid.width;
	public inline function get_height() return grid.height;

	function initCell( v: Int, x: Int, y: Int ) {
		return v;
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
	}

	public function update(): Void {
		var gridPrev = this.grid.grid;
		var gridNext = nextGridBuffer().grid;
		var width = this.width;
		var height = this.height;

		renderBuffer.clear();
		for ( x in 0...width ) {
			for ( y in 0...height ) {
				var newc = updateCell( gridPrev[x][y], x, y );
				gridNext[x][y] = newc;
				renderBuffer.add( newc, x, y );
			}
		}
		
		swapGridBuffers();
	}

	inline function nextGridBuffer() {
		return (this.grid == this.gridBuffer0) ? this.gridBuffer1 : this.gridBuffer0;
	}

	inline function swapGridBuffers() {
		var gridBuffer = nextGridBuffer();
		this.grid = gridBuffer;
	}

	public function render( renderer: Renderer, cellw: Int, cellh: Int, screenw: Int, screenh: Int ): Void {
	renderer.clear( screenw, screenh );
		renderer.render( renderBuffer, cellw, cellh );	
	}
}
