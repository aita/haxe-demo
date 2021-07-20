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

		var bitmap:Bitmap = new Bitmap(Assets.getBitmapData("assets/openfl.png"));
		bitmap.x = 100;
		bitmap.y = 100;

		var sprite:Sprite = new Sprite();
		sprite.addChild(bitmap);
		sprite.buttonMode = true;
		this.addChild(sprite);

		var offsetX = 0;
		var offsetY = 0;
		var targetX = 0;
		var targetY = 0;
		var dragging = false;

		function onDown(e:MouseEvent) {
			offsetX = cast(sprite.x - e.stageX, Int);
			offsetY = cast(sprite.y - e.stageY, Int);
			dragging = true;
		}

		function onUp(event:MouseEvent) {
			dragging = false;
		}

		function onFrame(e:Event) {
			if (dragging) {
				targetX = cast(stage.mouseX + offsetX, Int);
				targetY = cast(stage.mouseY + offsetY, Int);
			}

			var diffX = targetX - sprite.x;
			var diffY = targetY - sprite.y;

			if (Math.abs(diffX) < 1) {
				sprite.x = targetX;
			} else {
				sprite.x += (diffX * 0.2);
			}

			if (Math.abs(diffY) < 1) {
				sprite.y = targetY;
			} else {
				sprite.y += (diffY * 0.2);
			}
		}

		sprite.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
		sprite.addEventListener(MouseEvent.MOUSE_UP, onUp);
		stage.addEventListener(Event.ENTER_FRAME, onFrame);
	}
}
