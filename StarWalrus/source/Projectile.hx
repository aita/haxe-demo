package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class Projectile extends FlxSprite
{
	private var speed:Float = 2000;

	public function new()
	{
		super();

		frames = FlxAtlasFrames.fromTexturePackerJson(AssetPaths.ingameSprites__png, "assets/data/ingameSprites.json");
		animation.frameName = "projectile.png";
		this.velocity.x = speed;
	}
}
