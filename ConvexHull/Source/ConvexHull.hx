package;

import openfl.geom.Point;

class ConvexHull {
	// Monotone chain algorithm
	static public function getConvexHull(points:Array<Point>):Array<Point> {
		var points = points.copy();
		points.sort((a, b) -> {
			var dx = a.x - b.x;
			if (dx != 0) {
				return dx > 0 ? Math.ceil(dx) : -Math.ceil(Math.abs(dx));
			}
			var dy = a.y - b.y;
			return dy > 0 ? Math.ceil(dy) : -Math.ceil(Math.abs(dy));
		});

		var k = 0;
		var n = points.length;
		var loop = new Array<Point>();
		loop.resize(2 * n);

		for (i in 0...n) {
			while (k >= 2 && crossProduct(loop[k - 2], loop[k - 1], points[i]) <= 0) {
				k--;
			}
			loop[k++] = points[i];
		}

		var i = n - 1;
		var t = k + 1;
		while (i > 0) {
			while (k >= t && crossProduct(loop[k - 2], loop[k - 1], points[i - 1]) <= 0) {
				k--;
			}
			loop[k++] = points[i - 1];
			i--;
		}

		loop.resize(k - 1);

		return loop;
	}

	static function crossProduct(O:Point, A:Point, B:Point):Float {
		return (A.x - O.x) * (B.y - O.y) - (A.y - O.y) * (B.x - O.x);
	}
}
