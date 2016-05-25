package ca;

class CanvasRenderer {
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

	public function clear() { 
		for ( color in this.colors ) {
			this.counts[color] = 0;
		}
	}

	public function add( color: String, x: Int, y: Int ) {
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

	public function render( context: CanvasContext, cellw: Float, cellh: Float ) {
		for ( color in this.colors ) {
			var count = this.counts[color];
			if ( count > 0 ) {
				var buffer = this.buffers[color];

				context.beginPath();
				context.strokeStyle = color;
				var i = 0;
				while ( i < count ) {
					var x = buffer[i] * cellw;
					var y = buffer[i+1] * cellh;

					context.moveTo( x, y );
					context.lineTo( x + cellw, y + cellh );
					context.moveTo( x, y + cellh );
					context.lineTo( x + cellw, y );

					i += 2;
				}	
				context.stroke();
			}
		}
	}
}


