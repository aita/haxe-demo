package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import source.ui.LevelEndScreen;

class PlayState extends FlxState
{
	private var background:FlxSprite;
	private var txtScore:FlxText;
	private var txtTime:FlxText;

	private var numEnemies:Int = 20;
	private var score:Int = 0;
	private var enemyPointValue:Int = 155;
	private var enemies:Array<Enemy>;

	private var levelTimer:FlxTimer;
	private var levelTime:Int = 15;
	private var ticks:Int = 0;

	override public function create()
	{
		super.create();

		background = new FlxSprite();
		background.loadGraphic(AssetPaths.gameBackground__png);
		add(background);

		txtScore = new FlxText(10, 10, 200, "Score: 0", 20);
		txtTime = new FlxText(10, 30, 200, "Time: 0", 20);
		add(txtScore);
		add(txtTime);

		enemies = new Array<Enemy>();
		var enemy:Enemy;
		for (i in 0...numEnemies)
		{
			enemy = new Enemy();
			add(enemy);

			enemies.push(enemy);
			FlxMouseEventManager.add(enemy, onEnemyMouseDown);
		}

		levelTimer = new FlxTimer();
		levelTimer.start(1, onTimeComplete, levelTime);
	}

	override public function destroy():Void
	{
		super.destroy();

		for (i in 0...enemies.length)
		{
			FlxMouseEventManager.remove(enemies[i]);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	private function onEnemyMouseDown(object:FlxObject):Void
	{
		object.visible = false;
		score += enemyPointValue;
		txtScore.text = "Score: " + score;
	}

	private function onTimeComplete(timer:FlxTimer):Void
	{
		ticks++;
		txtTime.text = "Time: " + ticks;

		if (ticks >= levelTime)
		{
			var levelEndScreen:LevelEndScreen = new LevelEndScreen(score);
			add(levelEndScreen);
		}
	}
}
