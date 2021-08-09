package;

import AssetPaths;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class Enemy extends FlxSprite
{
	private var movementTween:FlxTween;

	private var spawnTimer:FlxTimer;
	private var maxSpawnTime:Float = 14;

	private var minSpeed:Float = 2.0;
	private var maxSpeed:Float = 3.5;

	private var maxX:Int = 750;
	private var minX:Int = 0;
	private var maxY:Int = 500;
	private var minY:Int = 0;

	public function new()
	{
		super();

		frames = FlxAtlasFrames.fromTexturePackerJson(AssetPaths.ingameSprites__png, "assets/data/ingameSprites.json");

		var frameNames:Array<String> = new Array<String>();
		frameNames.push("RocketKitty01.png");
		frameNames.push("RocketKitty02.png");

		animation.addByNames("Idle", frameNames, 8);
		animation.play("Idle");

		spawnTimer = new FlxTimer();
		resetSpawn();
	}

	private function resetSpawn(tween:FlxTween = null):Void
	{
		visible = false;
		this.alpha = 1;
		setPosition(FlxG.width + width, 0);

		var spawnTime:Float = Math.random() * (maxSpawnTime + 1);
		spawnTimer.start(spawnTime, onSpawn);
		this.solid = true;
	}

	private function onSpawn(timer:FlxTimer):Void
	{
		visible = true;

		var randomY:Int = (Math.floor(Math.random() * (maxY - minY + 1)) + minY);

		this.y = randomY;

		var randomSpeed:Float = (Math.random() * (maxSpeed - minSpeed + 1) + minSpeed);
		movementTween = FlxTween.tween(this, {x: -width}, randomSpeed, {ease: FlxEase.quadIn, onComplete: resetSpawn});
	}

	public function killEnemy():Void
	{
		this.solid = false;
		movementTween.cancel();
		FlxTween.tween(this, {alpha: 0}, 0.15, {ease: FlxEase.quadIn, onComplete: resetSpawn});
	}
}
