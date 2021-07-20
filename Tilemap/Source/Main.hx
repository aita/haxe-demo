package;

import openfl.display.*;
import openfl.events.Event;
import openfl.geom.Rectangle;
import openfl.Assets;

class Main extends Sprite {
	private var tilemap:Tilemap;

	private var tileset:Tileset;
	private var BLUE:Int;
	private var PINK:Int;
	private var YELLOW:Int;
	private var TEAL:Int;
	private var characters:Array<Character>;

	public function new() {
		super();

		this.stage.color = 0x555555;

		tileset = new Tileset(Assets.getBitmapData("assets/tileset.png"));
		BLUE = tileset.addRect(new Rectangle(0, 0, 32, 32));
		PINK = tileset.addRect(new Rectangle(32, 0, 32, 32));
		YELLOW = tileset.addRect(new Rectangle(0, 32, 32, 32));
		TEAL = tileset.addRect(new Rectangle(32, 32, 32, 32));
		tilemap = new Tilemap(stage.stageWidth, stage.stageHeight, tileset);
		addChild(tilemap);

		stage.addEventListener(Event.ENTER_FRAME, onFrame);
		characters = [];

		addCharacters(BLUE, 100);
		addCharacters(PINK, 100);
		addCharacters(YELLOW, 100);
		addCharacters(TEAL, 100);

		var fps:FPS = new FPS(10, 10, 0xffffff);
		addChild(fps);
	}

	private function addCharacters(type:Int, count:Int) {
		var i:Int;

		for (i in 0...count) {
			var posX:Float = Math.random() * stage.stageWidth;
			var posY:Float = Math.random() * stage.stageHeight;
			var velX:Float = Math.random() * 4 - 2;
			var velY:Float = Math.random() * 4 - 2;
			var char:Character = new Character(type, posX, posY, velY, velX);
			tilemap.addTile(char);
			characters.push(char);
		}
	}

	private function onFrame(e:Event) {
		for (char in characters) {
			char.x += char.velocity.x;
			char.y += char.velocity.y;

			if (char.x < 0 && char.velocity.x < 0) {
				char.velocity.x *= -1;
			} else if (char.x > stage.stageWidth && char.velocity.x > 0) {
				char.velocity.x *= -1;
			}

			if (char.y < 0 && char.velocity.y < 0) {
				char.velocity.y *= -1;
			} else if (char.y > stage.stageHeight && char.velocity.y > 0) {
				char.velocity.y *= -1;
			}

			if (char.velocity.x > 0) {
				char.scaleX = 1;
			} else {
				char.scaleX = -1;
			}
		}
	}
}
