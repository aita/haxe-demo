package;

import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();

		var helloWorldText = new FlxSprite();
		helloWorldText.loadGraphic(AssetPaths.HelloWorld__png);
		add(helloWorldText);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
