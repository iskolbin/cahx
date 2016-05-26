package ca;

class RenderBuffer {
	public var buffers(default,null): Map<String,Array<Float>>;
	public var counts(default,null): Map<String,Int>;
	public var colors(default,null): Array<String>;
	
	public function new( colors: Array<String> ) {
		this.colors = colors.copy();
		this.buffers = new Map<String,Array<Float>>();
		this.counts = new Map<String,Int>();
		for ( color in colors ) {
			this.buffers[color] = [];
			this.counts[color] = 0;
		}
	}	

	public inline function clear() { 
		for ( color in this.colors ) {
			this.counts[color] = 0;
		}
	}

	public inline function add( colorIndex: Int, x: Int, y: Int ) {
		var color = colors[colorIndex];

		if ( color == "" ) {
			return;
		}
		

		var buffer = this.buffers[color];
		var count = this.counts[color];
		
		if ( count == buffer.length ) {
			buffer.push( x );
			buffer.push( y );
		} else {
			buffer[count] = x;
			buffer[count+1] = y;
		}
		this.counts[color] = count + 2;
	}
}


