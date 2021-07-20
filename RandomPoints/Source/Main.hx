package;

import openfl.display.Sprite;
import Random;

class Main extends Sprite {
	public function new() {
		super();

		this.stage.color = 0x0;

		var color = 0xFFFFFF;
		this.graphics.beginFill(color);
		for (i in 0...500) {
			var x = Random.int(0, Std.int(this.stage.stageWidth));
			var y = Random.int(0, Std.int(this.stage.stageHeight));
			this.graphics.drawRect(x - 1, y - 1, 2, 2);
		}
		this.graphics.endFill();
	}
}
