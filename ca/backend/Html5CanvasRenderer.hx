package ca.backend;

import ca.Renderer;
import js.html.CanvasRenderingContext2D;

class Html5CanvasRenderer implements Renderer {
	public var context: CanvasRenderingContext2D;

	public function new( context: CanvasRenderingContext2D ) {
		this.context = context;
	}

	public function clear( screenw: Int, screenh: Int ) {
		context.clearRect( 0, 0, screenw, screenh );
	}

	public function renderRects( buffer: Array<Float>, count: Int, color: String, cellw: Int, cellh: Int ) {
		
		context.fillStyle = color;
		var i = 0;
		while ( i < count ) {
			var x = buffer[i] * cellw;
			var y = buffer[i+1] * cellh;
			context.fillRect( x, y, cellw, cellh );
			i += 2;
		}	
	}

	public function renderCross( buffer: Array<Float>, count: Int, color: String, cellw: Int, cellh: Int ){
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

	public function render( buffer: RenderBuffer, cellw: Int, cellh: Int ) {
		var counts = buffer.counts;
		var buffers = buffer.buffers;
		for ( color in buffer.colors ) {
			var count = counts[color];
			if ( count > 0 ) {
				var buffer = buffers[color];
				//renderRects( buffer, count, color, cellw, cellh );
				renderCross( buffer, count, color, cellw, cellh );
			}
		}
	}
}
