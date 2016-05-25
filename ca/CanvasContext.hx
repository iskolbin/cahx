package ca;

interface CanvasContext {
	public function beginPath(): Void;
	public function moveTo( x: Float, y: Float ): Void;
	public function lineTo( x: Float, y: Float ): Void;
	public function stroke(): Void;

	public var strokeStyle: String;
}

