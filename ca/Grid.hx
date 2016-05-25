package ca;

class Grid<T>{
	public var grid(default,null): Array<Array<T>>;
	public var width(default,null): Int;
	public var height(default,null): Int;

	public function new( width: Int, height: Int, initialValue: T = null ) {
		this.grid = [];
		this.width = width;
		this.height = height;
		for ( x in 0...width ) {
			var row = new Array<T>();
			for ( y in 0...height ) {
				row[y] = initialValue;
			}
			this.grid[x] = row;
		}
	}

	public function map( f: T->Int->Int->T, ?result_: Grid<T> ) {
		var result = result_ == null ? new Grid( this.width, this.height, null ) : result_;
		for ( x in 0...this.width ) {
			for ( y in 0...this.height ) {
				result.grid[x][y] = f( this.grid[x][y], x, y );
			}
		}
		return result;
	}

	public inline function each( f: T->Int->Int->Void ) {
		for ( x in 0...this.width ) {
			for ( y in 0...this.height ) {
				f( this.grid[x][y], x, y );
			}
		}
	}

	inline function unit( v: T, x: Int, y: Int ): T return v;

	public inline function copy( ?result_: Grid<T> ) {
		return map( unit, result_ ) ;
	}
	
	public inline function max( a: Int, b: Int ) return a > b ? a : b;

	public inline function min( a: Int, b: Int ) return a < b ? a : b;

	public function getNeighborsNeumann( x_: Int, y_: Int, n: Int ) {
		var result = new Array<T>();
		var x0 = max(0,x_-n);
		var x1 = min(this.width,x_+n+1);
		var y0 = max(0,y_-n);
		var y1 = min(this.height,y_+n+1);
		for ( x in x0...x1 ) {
			for ( y in y0...y1 ) {
				var dist = Math.abs(x-x_) + Math.abs(y-y_);
				if ( dist > 0 && dist <= n ) {
					result.push( this.grid[x][y] );
				}
			}
		}
		return result;
	}

	public function getNeighborsMoore( x_: Int, y_: Int, n: Int ) {		
		var result = new Array<T>();
		var x0 = max(0,x_-n);
		var x1 = min(this.width,x_+n+1);
		var y0 = max(0,y_-n);
		var y1 = min(this.height,y_+n+1);
		for ( x in x0...x1 ) {
			for ( y in y0...y1 ) {
				if ( x != x_ || y != y_ ) {
					result.push( this.grid[x][y] );
				}
			}
		}
		return result;
	}
	
	public inline function unsafeGet( x: Int, y: Int ) {
		return this.grid[x][y];
	}

	public inline function unsafeSet( x: Int, y: Int, v: T ) {
		this.grid[x][y] = v;
	}

	public function get( x: Int, y: Int ) {
		if ( !inside(x,y) ) {
			throw 'Point ($x,$y) is outside of the grid ${this.width}x${this.height}!';
		}
		return unsafeGet( x, y );
	}

	public function set( x: Int, y: Int, v: T ) {
		if ( !inside(x,y) ) {
			throw 'Point ($x,$y) is outside of the grid ${this.width}x${this.height}!';
		}
		unsafeSet( x, y, v );
	}

	public inline function inside( x: Int, y: Int ) {
		return x >= 0 && x < this.width && y >= 0 && y < this.height;
	}
}
