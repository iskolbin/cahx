package ca;

interface Renderer {
	public function clear( screenw: Int, screenh: Int ): Void;
	public function render( buffer: RenderBuffer, cellw: Int, cellh: Int ): Void;
}	
