package;

import lime.math.Vector2;
import openfl.display.Tile;

class Particle extends Tile {
	public var acceleration:Vector2;
	public var velocity:Vector2;

	public function new(type:Int, x:Float, y:Float, accelerationX:Float, accelerationY:Float, velocityX:Float, velocityY:Float) {
		super(type, x, y);
		acceleration = new Vector2(accelerationX, accelerationY);
		velocity = new Vector2(velocityX, velocityY);
	}
}
