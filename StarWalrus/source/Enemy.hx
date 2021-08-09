package;

import AssetPaths;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class Enemy extends FlxSprite
{
	private var movementTween:FlxTween;

	private var spawnTimer:FlxTimer;

	private var movementSpeed:Float;
	private var movementPattern:Dynamic;
	private var movementPoints:Array<FlxPoint>;

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
	}

	private function resetSpawn(tween:FlxTween = null):Void
	{
		this.solid = true;
		this.alpha = 1;
		this.kill();
	}

	public function startPattern(speed:Float, pattern:Dynamic):Void
	{
		movementSpeed = speed;
		movementPattern = pattern;
		movementPoints = new Array<FlxPoint>();

		var point:FlxPoint;
		for (i in 0...movementPattern.points.length)
		{
			point = new FlxPoint(movementPattern.points[i][0], movementPattern.points[i][1]);
			movementPoints.push(point);
		}

		spawnTimer.start(movementPattern.startDelay, onSpawn);
		setPosition(FlxG.stage.stageWidth + width, movementPattern.startY);
	}

	private function onSpawn(timer:FlxTimer):Void
	{
		movementTween = FlxTween.quadPath(this, movementPoints, movementSpeed, true, {ease: FlxEase.quadIn, onComplete: resetSpawn});
	}

	public function killEnemy():Void
	{
		this.solid = false;
		movementTween.cancel();
		FlxTween.tween(this, {alpha: 0}, 0.15, {ease: FlxEase.quadIn, onComplete: resetSpawn});
	}
}
