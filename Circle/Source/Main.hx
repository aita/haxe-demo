package;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.events.Event;
import openfl.events.MouseEvent;

class Main extends Sprite {
	public function new() {
		super();

		var circle:Sprite = new Sprite();
		circle.graphics.lineStyle(5);
		var w = this.stage.stageWidth;
		var h = this.stage.stageHeight;
		var r = Math.min(w, h) / 2 / 10;
		circle.graphics.drawCircle(0, 0, r);

		var hitArea:Sprite = new Sprite();
		hitArea.visible = false;
		hitArea.graphics.beginFill();
		hitArea.graphics.drawCircle(0, 0, r);
		circle.hitArea = hitArea;
		hitArea.mouseEnabled = false;
		circle.addChild(hitArea);

		addChild(circle);

		circle.x = 100;
		circle.y = 100;

		var offsetX = 0;
		var offsetY = 0;
		var targetX = 0;
		var targetY = 0;
		var dragging = false;

		function onDown(e:MouseEvent) {
			cast(e.currentTarget, Sprite).startDrag();
		}

		function onUp(e:MouseEvent) {
			cast(e.currentTarget, Sprite).stopDrag();
		}

		circle.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
		circle.addEventListener(MouseEvent.MOUSE_UP, onUp);
	}
}
