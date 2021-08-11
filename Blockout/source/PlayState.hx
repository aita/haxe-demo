package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	static inline var BALL_SIZE:Int = 6;
	static inline var BAT_SPEED:Int = 350;
	static inline var BAT_WIDTH:Int = 40;

	var bat:FlxSprite;
	var ball:FlxSprite;

	var walls:FlxGroup;
	var leftWall:FlxSprite;
	var rightWall:FlxSprite;
	var topWall:FlxSprite;
	var bottomWall:FlxSprite;

	var bricks:FlxGroup;

	override public function create():Void
	{
		FlxG.mouse.visible = false;

		bat = new FlxSprite(FlxG.width / 2 - BAT_WIDTH / 2, FlxG.height - 20);
		bat.makeGraphic(BAT_WIDTH, 6, FlxColor.MAGENTA);
		bat.immovable = true;

		ball = new FlxSprite(FlxG.width / 2 - BALL_SIZE / 2, FlxG.height / 2 - BALL_SIZE / 2);
		ball.makeGraphic(BALL_SIZE, BALL_SIZE, FlxColor.MAGENTA);

		ball.elasticity = 1;
		ball.maxVelocity.set(200, 200);
		ball.velocity.y = 200;

		walls = new FlxGroup();

		leftWall = new FlxSprite(-10, 0);
		leftWall.makeGraphic(10, FlxG.height, FlxColor.TRANSPARENT);
		leftWall.immovable = true;
		walls.add(leftWall);

		rightWall = new FlxSprite(FlxG.width, 0);
		rightWall.makeGraphic(10, FlxG.height, FlxColor.TRANSPARENT);
		rightWall.immovable = true;
		walls.add(rightWall);

		topWall = new FlxSprite(0, -10);
		topWall.makeGraphic(FlxG.width, 10, FlxColor.TRANSPARENT);
		topWall.immovable = true;
		walls.add(topWall);

		bottomWall = new FlxSprite(0, FlxG.height);
		bottomWall.makeGraphic(FlxG.width, 10, FlxColor.TRANSPARENT);
		bottomWall.immovable = true;
		walls.add(bottomWall);

		// Some bricks
		bricks = new FlxGroup();

		var bx:Int = 10;
		var by:Int = 40;

		var brickColours:Array<Int> = [0xffd03ad1, 0xfff75352, 0xfffd8014, 0xffff9024, 0xff05b320, 0xff6d65f6];
		var blockWidth:Int = 31;
		for (y in 0...6)
		{
			for (x in 0...20)
			{
				var tempBrick:FlxSprite = new FlxSprite(bx + 2, by);
				tempBrick.makeGraphic(blockWidth - 2, 15, brickColours[y]);
				tempBrick.immovable = true;
				bricks.add(tempBrick);
				bx += blockWidth;
			}

			bx = 10;
			by += 18;
		}

		add(walls);
		add(bat);
		add(ball);
		add(bricks);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		bat.velocity.x = 0;

		if (FlxG.keys.anyPressed([LEFT, A]) && bat.x > 0)
		{
			bat.velocity.x = -BAT_SPEED;
		}
		else if (FlxG.keys.anyPressed([RIGHT, D]) && bat.x < FlxG.width - BAT_WIDTH)
		{
			bat.velocity.x = BAT_SPEED;
		}

		if (FlxG.keys.justReleased.R)
		{
			FlxG.resetState();
		}

		if (bat.x < 0)
		{
			bat.x = 0;
		}

		if (bat.x > FlxG.width - BAT_WIDTH)
		{
			bat.x = FlxG.width - BAT_WIDTH;
		}

		FlxG.collide(ball, walls);
		FlxG.collide(bat, ball, ping);
		FlxG.collide(ball, bricks, hit);
	}

	function hit(Ball:FlxObject, Brick:FlxObject):Void
	{
		Brick.exists = false;
	}

	function ping(Bat:FlxObject, Ball:FlxObject):Void
	{
		var batmid:Int = Std.int(Bat.x) + 20;
		var ballmid:Int = Std.int(Ball.x) + 3;
		var diff:Int;

		if (ballmid < batmid)
		{
			// Ball is on the left of the bat
			diff = batmid - ballmid;
			Ball.velocity.x = (-10 * diff);
		}
		else if (ballmid > batmid)
		{
			// Ball on the right of the bat
			diff = ballmid - batmid;
			Ball.velocity.x = (10 * diff);
		}
		else
		{
			// Ball is perfectly in the middle
			// A little random X to stop it bouncing up!
			Ball.velocity.x = 2 + FlxG.random.int(0, 8);
		}
	}
}
