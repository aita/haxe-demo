package;

import openfl.geom.Point;
import openfl.events.KeyboardEvent;
import openfl.display.Tile;
import openfl.geom.Rectangle;
import openfl.display.FPS;
import openfl.Assets;
import openfl.events.Event;
import openfl.display.Tileset;
import openfl.display.Tilemap;
import openfl.display.Sprite;

class Main extends Sprite {
	private var tilemap:Tilemap;
	private var tileset:Tileset;
	private var tileSize:Int;
	private var character:PlayerCharacter;
	private var map:Array<Array<Int>>;
	private var keysHeld:Array<Bool>;

	// private var entities:Array<Tile>;

	public function new() {
		super();

		stage.align = openfl.display.StageAlign.TOP_LEFT;
		stage.scaleMode = openfl.display.StageScaleMode.NO_SCALE;

		tileset = new Tileset(Assets.getBitmapData("assets/set.png"));
		tileset.addRect(new Rectangle(0, 0, 32, 32));
		tileset.addRect(new Rectangle(32, 0, 32, 32));

		tilemap = new Tilemap(stage.stageWidth, stage.stageHeight, tileset);
		tileSize = 32;
		map = new Array<Array<Int>>();
		TileMap.create(map);
		for (row in 0...map.length) {
			for (cell in 0...map[row].length) {
				var tile = new Tile(map[row][cell], tileSize * cell, tileSize * row);
				tilemap.addTile(tile);
			}
		}
		addChild(tilemap);

		character = new PlayerCharacter(tileset);
		tilemap.addTile(character);

		// Collectible flags
		var flagTileId:Int = tileset.addRect(new Rectangle(64, 0, 32, 32));
		tilemap.addTile(new Flag(flagTileId, 10, 10, tileSize));
		tilemap.addTile(new Flag(flagTileId, 2, 2, tileSize));
		tilemap.addTile(new Flag(flagTileId, 4, 12, tileSize));
		tilemap.addTile(new Flag(flagTileId, 22, 10, tileSize));
		tilemap.addTile(new Flag(flagTileId, 20, 3, tileSize));

		stage.addEventListener(Event.ENTER_FRAME, onFrame);

		// Keyboard
		keysHeld = new Array<Bool>();
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);

		var fps:FPS = new FPS(10, 10, 0xffffff);
		addChild(fps);
	}

	private function onFrame(ev:Event):Void {
		var move:Point = new Point();

		// Character walking
		if (keysHeld[38]) {
			character.face(Up);
			character.animate();
			move.y -= character.movementSpeed;
		} else if (keysHeld[39]) {
			character.face(Right);
			character.animate();
			move.x += character.movementSpeed;
		} else if (keysHeld[40]) {
			character.face(Down);
			character.animate();
			move.y += character.movementSpeed;
		} else if (keysHeld[37]) {
			character.face(Left);
			character.animate();
			move.x -= character.movementSpeed;
		} else {
			character.resetAnim();
		}

		var pos:Point = new Point(character.x, character.y);
		TileCollisionDetector.detect(map, pos, move, tileSize);
		character.x = pos.x;
		character.y = pos.y;

		// player-flag collisions
		for (idx in 0...tilemap.numTiles) {
			var entity = tilemap.getTileAt(idx);
			if (Std.isOfType(entity, Flag)) {
				var flag:Flag = cast(entity, Flag);
				if (Point.distance(new Point(character.x, character.y), new Point(flag.x, flag.y)) <= flag.radius) {
					if (flag.collide(character)) {
						tilemap.removeTile(flag);
						break;
					};
				}
			}
		}
	}

	private function keyDown(ev:KeyboardEvent):Void {
		keysHeld[ev.keyCode] = true;
	}

	private function keyUp(ev:KeyboardEvent):Void {
		keysHeld[ev.keyCode] = false;
	}
}
