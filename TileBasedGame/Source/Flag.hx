package;

import openfl.display.Tile;

/**
 * Collectible flag entity.
 * @author Kirill Poletaev
 */
class Flag extends Tile {
	private var entities:Array<Tile>;

	public var radius:Int;

	public function new(tileId:Int, gridX:Int, gridY:Int, tileSize:Int) {
		super(tileId, gridX * tileSize, gridY * tileSize);
		radius = tileSize;
	}

	public function collide(object:Tile):Bool {
		if (Std.isOfType(object, PlayerCharacter)) {
			return true;
		}
		return false;
	}
}
