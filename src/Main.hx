package;

import openfl.display.Sprite;
import openfl.Lib;
import flixel.*;
/**
 * ...
 * @author bbpanzu
 */
class Main extends Sprite 
{

	public function new() 
	{
		super();
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		
		addChild(new FlxGame(1066, 600, PlayState, 1,24,24));
		
	}

}
