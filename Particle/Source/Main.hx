package;

import openfl.display.*;
import openfl.events.Event;
import openfl.geom.Rectangle;

class Main extends Sprite {
	var tilemap:Tilemap;
	var tileset:Tileset;
	var screen:Sprite;
	var particles:Array<Particle>;

	var RECT:Int;

	public function new() {
		super();

		particles = new Array<Particle>();
		var particle:BitmapData = new BitmapData(4, 4, false, 0x0000ff);
		tileset = new Tileset(particle);
		RECT = tileset.addRect(new Rectangle(0, 0, 4, 4));
		tilemap = new Tilemap(stage.stageWidth, stage.stageHeight, tileset);
		addChild(tilemap);

		this.addEventListener(Event.ENTER_FRAME, update);
	}

	public function update(e:Event) {
		var vx = Math.random() * 7.0 + 3.0;
		var vy = Math.random() * 5.0;
		var newParticle:Particle = new Particle(RECT, 0.0, 0.0, 0.0, 0.5, vx, vy);
		particles.push(newParticle);
		tilemap.addTile(newParticle);

		for (particle in particles) {
			if (particle.x > stage.stageWidth) {
				particles.remove(particle);
				tilemap.removeTile(particle);
			} else {
				particle.x += particle.velocity.x;
				particle.y += particle.velocity.y;
				particle.velocity.x += particle.acceleration.x;
				particle.velocity.y += particle.acceleration.y;
				if (particle.y > stage.stageHeight) {
					particle.y = stage.stageHeight;
					particle.velocity.y *= -Math.random() * 0.7;
				}
			}
		}
	}
}
