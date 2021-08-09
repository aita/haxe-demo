package;

import audio.SoundManager;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.FlxFlicker;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import ui.StringIDs;
import ui.Strings;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var background:FlxSprite;
	private var star:FlxSprite;
	private var logo:FlxSprite;

	public var checkForInput:Bool = false;

	private var txtInstructions:FlxText;

	override public function create():Void
	{
		super.create();
		Strings.instance.init();

		background = new FlxSprite();
		background.loadGraphic(AssetPaths.titleScreenBackground__png);
		background.visible = false;
		background.screenCenter();
		add(background);

		star = new FlxSprite();
		star.loadGraphic(AssetPaths.titleScreenStar__png);
		star.setPosition(3000, 276);
		add(star);

		logo = new FlxSprite();
		logo.loadGraphic(AssetPaths.titleScreenLogo__png);
		logo.setPosition(59, 360);
		logo.visible = false;
		add(logo);

		txtInstructions = new FlxText(0, 0, 500);
		txtInstructions.text = Strings.instance.getValue(StringIDs.TAP_TO_START);
		txtInstructions.setFormat(AssetPaths.BebasNeue__otf, 72, FlxColor.WHITE, "center");
		txtInstructions.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 3);

		txtInstructions.setPosition(FlxG.width / 2 - txtInstructions.width / 2, 0);
		txtInstructions.visible = false;

		add(txtInstructions);

		FlxTween.tween(star, {x: 0}, 1.0, {ease: FlxEase.quadIn, onComplete: onStarAnimateIn});

		SoundManager.instance.playFanfareMusic();
		SoundManager.instance.playWhooshSound(0.75);
	}

	private function onStarAnimateIn(tween:FlxTween):Void
	{
		logo.visible = true;
		FlxG.camera.flash(FlxColor.WHITE, 0.25, onFlashComplete);
		FlxG.camera.shake();
		background.visible = true;

		SoundManager.instance.playTingSound();
	}

	private function onFlashComplete():Void
	{
		FlxFlicker.flicker(txtInstructions, 0, 0.5);
		checkForInput = true;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (checkForInput && FlxG.mouse.justReleased)
		{
			goToGame();
		}
	}

	private function goToGame():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function()
		{
			FlxG.switchState(new PlayState());
		});

		SoundManager.instance.playClickSound();
	}
}
