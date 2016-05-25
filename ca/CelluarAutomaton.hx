package ca;

interface CelluarAutomaton {
	public function update(): Void;
	public function render( context: CanvasContext, cellw: Float, cellh: Float ): Void;
}
