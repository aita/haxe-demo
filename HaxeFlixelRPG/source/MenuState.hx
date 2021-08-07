package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	override public function create():Void
	{
		super.create();

		var init_x:Int = Math.floor(FlxG.width / 2 - 40);

		var btn_new = new FlxButton(init_x, 50, "New game", onNew);
		var btn_load = new FlxButton(init_x, 80, "Load", onLoad);

		add(btn_new);
		add(btn_load);
	}

	private function onNew():Void
	{
		var playState:PlayState = new PlayState();
		FlxG.switchState(playState);
		playState.loadedGame = false;
	}

	private function onLoad():Void
	{
		var playState:PlayState = new PlayState();
		FlxG.switchState(playState);
		playState.loadedGame = true;
	}
}
