package ;

import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;

import ca.CelluarAutomaton;

#if js @:expose("CelluarAutomaton") #end
class Html5Test {
	public static var cellw = 8;
	public static var cellh = 8;
	public static var canvas: CanvasElement = null;
	public static var context: CanvasRenderingContext2D = null;
	public static var frameLen = 1000.0 * (1.0 / 60.0);
	public static var w = 640;
	public static var h = 480;
	public static var automaton: CelluarAutomaton = null;
	public static var predstamp = 0.0;

	static function init() {
		canvas.width = canvas.offsetWidth;
		canvas.height = canvas.offsetHeight;
		w = canvas.width;
		h = canvas.height;
		var gridw = Std.int( w/cellw );
		var gridh = Std.int( h/cellh );
		automaton = new ca.impl.ForestFireCa( gridw, gridh, 0.00001, 0.01 );
		//automaton = new ca.impl.GenerationsCa( gridw, gridh, ['red','orange','yellow','green','cyan','blue','purple'] );
	}

	static function update( timestamp: Float ) {
		if ( predstamp == 0.0 ) {
			predstamp = timestamp;
			automaton.render( cast context, cellw, cellh );
		} else {
			var dt = timestamp - predstamp;
			if ( dt >= frameLen ) {
				//context.fillStyle = "rgba(0,0,0,0.1)";
				context.clearRect(0,0,w,h);
				automaton.update();
				automaton.render( cast context, cellw, cellh );
				predstamp = timestamp;
			}
		}

		Browser.window.requestAnimationFrame( update );
	}
	
	public static function main() {
		canvas = cast Browser.document.getElementById( "canvasObj" );
		context = canvas.getContext("2d");
			
		Browser.window.onload = init;
		Browser.window.onresize = init;

		Browser.window.requestAnimationFrame( update );
	}
}
