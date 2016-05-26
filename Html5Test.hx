package ;

import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;

import ca.CelluarAutomaton;
import ca.Renderer;

#if js @:expose("CelluarAutomaton") #end
class Html5Test {
	public static var cellw = 4;
	public static var cellh = 4;
	public static var canvas: CanvasElement = null;
	public static var context: CanvasRenderingContext2D = null;
	public static var frameLen = 1000.0 * (1.0 / 60.0);
	public static var w = 640;
	public static var h = 480;
	public static var automaton: CelluarAutomaton = null;
	public static var renderer: Renderer = null;
	public static var predstamp = 0.0;
	public static var simulationInterval = 100;

	static function init() {
		canvas.width = canvas.offsetWidth;
		canvas.height = canvas.offsetHeight;
		w = canvas.width;
		h = canvas.height;
		var gridw = Std.int( w/cellw );
		var gridh = Std.int( h/cellh );
		//automaton = new ca.impl.ForestFireCa( gridw, gridh, 0.00001, 0.01 );
		//automaton = new ca.impl.GenerationsCa( gridw, gridh, 10 );
		automaton = new ca.impl.GameOfLifeCa( gridw, gridh, 0.5 );
		renderer = new ca.backend.Html5CanvasRenderer( context );
		
		update();
	}

	static function render( timestamp: Float ) {
		if ( predstamp == 0.0 ) {
			predstamp = timestamp;
			automaton.render( renderer, cellw, cellh, w, h );
		} else {
			var dt = timestamp - predstamp;
			if ( dt >= frameLen ) {
				//automaton.update();
				automaton.render( renderer, cellw, cellh, w, h );
				predstamp = timestamp;
			}
		}

		Browser.window.requestAnimationFrame( render );
	}

	static function update() {
		automaton.update();
		haxe.Timer.delay( update, simulationInterval );
	}
	
	public static function main() {
		canvas = cast Browser.document.getElementById( "canvasObj" );
		context = canvas.getContext("2d");
			
		Browser.window.onload = init;
		Browser.window.onresize = init;

		Browser.window.requestAnimationFrame( render );
	}
}
