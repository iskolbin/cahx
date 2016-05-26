package ca.color;

abstract Hsv(Array<Float>) from Array<Float> to Array<Float> {
	public inline function new( hue: Float, saturation: Float, value: Float ) {
		this = [hue,saturation,value];
	}
	
	public static inline var ONE_SIXTH_CIRCLE = 60.0;
	public static inline var FULL_CIRCLE = ONE_SIXTH_CIRCLE * 6.0;
	public static inline var ONE_THIRD_CIRCLE = 2 * ONE_SIXTH_CIRCLE;
	public static inline var TWO_THIRDS_CIRCLE = 4 * ONE_SIXTH_CIRCLE;

	public inline function hue() return this[0];
	public inline function saturation() return this[1];
	public inline function value() return this[2];

	@:to public function toRgb() {
		var v = value();
		var vmin = ( 1 - saturation()) * v;
		var a = ( value() - vmin ) * ( (hue() % 60.0) / 60.0 );
		var vinc = vmin + a;
		var vdec = v - a;
		var part = Std.int( hue() / ONE_SIXTH_CIRCLE ) % 6;
		return switch ( part ) {
			case 0: new Rgb( v, vinc, vmin );
			case 1: new Rgb( vdec, v, vmin );
			case 2: new Rgb( vmin, v, vinc );
			case 3: new Rgb( vmin, vdec, v );
			case 4: new Rgb( vinc, vmin, v );
			case _: new Rgb( v, vmin, vdec );
		}	
	}
	
	@:from public static function fromRgb( rgb: Rgb ) return rgb.toHsv();
}
