package;

import openfl.Vector;
import openfl.display.GraphicsPathCommand;
import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;
import openfl.geom.Point;
import openfl.events.MouseEvent;
import openfl.display.Sprite;

class Main extends Sprite {
	var points:Array<Point>;

	public function new() {
		super();
		points = new Array();
		stage.addEventListener("click", onClick);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

		draw();
	}

	function onClick(event:MouseEvent) {
		points.push(new Point(event.stageX, event.stageY));
		// trace(points);
		draw();
	}

	function onKeyDown(event:KeyboardEvent) {
		if (event.keyCode == Keyboard.Q) {
			points = new Array();
			draw();
		}
	}

	function draw() {
		graphics.clear();
		if (points.length >= 3) {
			var loop = ConvexHull.getConvexHull(points);
			drawLoop(loop);
		}
		drawPoints();
	}

	function drawPoints() {
		graphics.lineStyle(0, 0x000000, 0.0);
		graphics.beginFill(0x000000);
		for (point in points) {
			graphics.drawCircle(point.x, point.y, 4);
		}
		graphics.endFill();
	}

	function drawLoop(loop:Array<Point>) {
		graphics.lineStyle(2, 0xFF0000, 1.0);
		var commands = new Vector<Int>((loop.length + 1), true);
		commands[0] = GraphicsPathCommand.MOVE_TO;
		for (i in 0...loop.length) {
			commands[i + 1] = GraphicsPathCommand.LINE_TO;
		}
		var data = new Vector<Float>((loop.length + 1) * 2, true);
		for (i in 0...loop.length) {
			data[i * 2] = loop[i].x;
			data[i * 2 + 1] = loop[i].y;
		}
		data[loop.length * 2] = loop[0].x;
		data[loop.length * 2 + 1] = loop[0].y;
		graphics.drawPath(commands, data);
	}
}
