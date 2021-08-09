package ui;

import haxe.xml.Access;
import openfl.Assets;

class Strings
{
	private var access:Access;

	public static var instance(get, null):Strings;

	public function new() {}

	public function init():Void
	{
		var stringXML = Xml.parse(Assets.getText(AssetPaths.strings__xml));
		access = new Access(stringXML.firstElement());
	}

	private static function get_instance():Strings
	{
		if (instance == null)
		{
			instance = new Strings();
		}
		return instance;
	}

	public function getValue(id:String):String
	{
		for (string in access.nodes.string)
		{
			if (id == string.att.id)
			{
				return string.innerData;
			}
		}
		return "";
	}
}
