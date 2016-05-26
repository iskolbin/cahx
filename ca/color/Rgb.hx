package ca.color;

abstract Rgb(Array<Float>) from Array<Float> to Array<Float> {
	public inline function new( red: Float, green: Float, blue: Float ) {
		this = [red,green,blue];
	}
	
	public inline function red() return this[0];
	public inline function green() return this[1];
	public inline function blue() return this[2];

	@:to public function toHsv() {
		var red = red();
		var green = green();
		var blue = blue();
		var min = Math.min( red, Math.min( green, blue ));
		var max = Math.max( red, Math.max( green, blue ));
		
		var hue = 0.0;
		if ( max != min ) {
			if ( max == red ) {
				hue = Hsv.ONE_SIXTH_CIRCLE * ( green - blue ) / ( max - min );
				if ( green < blue ) {
					hue += Hsv.FULL_CIRCLE;
				}
			} else if ( max == green ) {
				hue = ( blue - red ) / ( max - min ) + Hsv.ONE_THIRD_CIRCLE;
			} else {
				hue = ( red - green ) / ( max - min ) + Hsv.TWO_THIRDS_CIRCLE;
			}
		}

		var saturation = ( max == 0.0 ) ? 0.0 : 1.0 - (min/max);

		return new Hsv( hue, saturation, max );
	}

	@:to public inline function toInt() {
		return (Std.int(red()*0xff) << 0x10) + 
			(Std.int(green()*0xff) << 0x08) + 
			(Std.int(blue()*0xff));
	}
	
	@:to public inline function toString() {
		return StringTools.hex( toInt() );
	}

	@:from public static function fromHsv( hsv: Hsv ) return hsv.toRgb();
}
