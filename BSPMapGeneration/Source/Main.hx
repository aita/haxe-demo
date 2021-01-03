package;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.events.MouseEvent;
import feathers.controls.Button;
import openfl.display.Graphics;
import openfl.display.Sprite;
import openfl.geom.Rectangle;

class Main extends Sprite {
	static inline var TILE_SIZE:Int = 16;

	var rooms:Array<Rectangle>;
	var corridors:Array<Rectangle>;
	var leafs:Array<BSPLeaf>;
	var map:Sprite;
	var mapWidth:Int;
	var mapHeight:Int;

	public function new() {
		super();

		mapWidth = Math.ceil(stage.stageWidth / TILE_SIZE);
		mapHeight = Math.ceil(stage.stageHeight / TILE_SIZE);

		map = new Sprite();
		addChild(map);

		var button = new Button();
		button.text = "Generate";
		button.x = 20;
		button.y = 20;
		button.addEventListener(MouseEvent.CLICK, onClicked);
		this.addChild(button);

		generateMap();
	}

	function onClicked(event:MouseEvent):Void {
		generateMap();
	}

	function generateMap():Void {
		rooms = [];
		corridors = [];
		leafs = [];

		var root = new BSPLeaf(0, 0, mapWidth, mapHeight);
		leafs.push(root);

		var didSplit:Bool = true;
		while (didSplit) {
			didSplit = false;

			for (leaf in leafs) {
				if (leaf.left == null && leaf.right == null) // If not split
				{
					if (leaf.width > BSPLeaf.MAX_SIZE || leaf.height > BSPLeaf.MAX_SIZE || Random.float(0, 1) > 0.25) {
						if (leaf.split()) // split the leaf!
						{
							leafs.push(leaf.left);
							leafs.push(leaf.right);
							didSplit = true;
						}
					}
				}
			}
		}

		root.createRooms();
		root.createCorridors();

		for (leaf in leafs) {
			if (leaf.room != null) {
				rooms.push(leaf.room);
			}

			if (leaf.corridor != null) {
				corridors.push(leaf.corridor);
			}
		}

		drawMap();
	}

	function drawMap():Void {
		map.removeChildren();

		var bitmapData = new BitmapData(mapWidth, mapHeight, false, 0x000000);
		for (room in rooms) {
			bitmapData.fillRect(room, 0xFFFFFF);
		}
		for (corridor in corridors) {
			bitmapData.fillRect(corridor, 0xFFFFFF);
		}

		var bitmap = new Bitmap(bitmapData);
		bitmap.scaleX = TILE_SIZE;
		bitmap.scaleY = TILE_SIZE;
		map.addChild(bitmap);

		var guide = new Sprite();
		guide.graphics.lineStyle(1, 0xFF0000);
		for (leaf in leafs) {
			guide.graphics.drawRect(leaf.x * TILE_SIZE, leaf.y * TILE_SIZE, leaf.width * TILE_SIZE, leaf.height * TILE_SIZE);
		}
		map.addChild(guide);
	}
}
