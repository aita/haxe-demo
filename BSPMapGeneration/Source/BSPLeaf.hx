import openfl.geom.Rectangle;
import openfl.geom.Point;
import Random;

class BSPLeaf {
	public static inline var MIN_SIZE = 6;
	public static inline var MAX_SIZE = 24;

	public var x:Int;
	public var y:Int;
	public var width:Int;
	public var height:Int;

	public var left:BSPLeaf;
	public var right:BSPLeaf;
	public var room:Rectangle;
	public var corridor:Rectangle;

	public function new(x:Int, y:Int, width:Int, height:Int) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}

	public function split():Bool {
		if (left != null || right != null)
			return false; // Already split

		var horizontal:Bool = Random.float(0, 1) > 0.5;

		if (width > height && height / width >= 0.05)
			horizontal = false;
		else if (height > width && width / height >= 0.05)
			horizontal = true;

		var max = (horizontal ? height : width) - MIN_SIZE;
		if (max <= MIN_SIZE)
			return false;

		var split = Std.int(Random.float(MIN_SIZE, max));

		if (horizontal) {
			left = new BSPLeaf(x, y, width, split);
			right = new BSPLeaf(x, y + split, width, height - split);
		} else {
			left = new BSPLeaf(x, y, split, height);
			right = new BSPLeaf(x + split, y, width - split, height);
		}

		return true;
	}

	public function createRooms():Void {
		if (left != null || right != null) {
			if (left != null) {
				left.createRooms();
			}
			if (right != null) {
				right.createRooms();
			}
		} else {
			var roomX = x + Random.float(0, width / 3);
			var roomY = y + Random.float(0, height / 3);
			var roomW = width - (roomX - x);
			var roomH = height - (roomY - y);
			roomW -= Random.float(0, roomW / 3);
			roomH -= Random.float(0, roomH / 3);
			room = new Rectangle(roomX, roomY, roomW, roomH);
		}
	}

	public function createCorridors():Void {
		if (left != null) {
			left.createCorridors();
		}
		if (right != null) {
			right.createCorridors();
		}
		if (left != null && right != null) {
			var p1 = new Point(Math.ceil(left.x + left.width / 2), Math.ceil(left.y + left.height / 2));
			var p2 = new Point(Math.ceil(right.x + right.width / 2), Math.ceil(right.y + right.height / 2));
			var x = (p1.x < p2.x) ? p1.x : p2.x;
			var y = (p1.y < p2.y) ? p1.y : p2.y;
			var w = Math.abs(p1.x - p2.x);
			var h = Math.abs(p1.y - p2.y);
			corridor = new Rectangle(x, y, w + 1, h + 1);
		}
	}
}
