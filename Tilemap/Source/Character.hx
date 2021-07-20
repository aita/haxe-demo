package;

import lime.math.Vector2;
import openfl.display.Tile;

class Character extends Tile {
	public var velocity:Vector2;

	public function new(type:Int, x:Float, y:Float, velocityX:Float, velocityY:Float) {
		super(type, x, y);

		velocity = new Vector2(velocityX, velocityY);
	}
}
