package;
import flixel.*;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxSound;

/**
 * ...
 * @author bbpanzu
 */
class PlayState extends FlxState
{
	var panzu:FlxSprite;
	var kaya:FlxSprite;
	var directions:FlxSprite;
	var kaya_meter:FlxSprite;
	var panzu_meter:FlxSprite;
	
	var panzu_love:Float = 0;
	var kaya_love:Float = 0;
	
	var wobble:FlxSound;
	var steam:FlxSound;
	
	var daKiss:Int = 0;
	
	var ext:String = ".mp3";
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		
		#if desktop
		ext = ".ogg";
		#end
		

		FlxG.sound.cache("assets/kiss0"+ext);
		FlxG.sound.cache("assets/kiss1"+ext);
		FlxG.sound.cache("assets/kiss2"+ext);
		FlxG.sound.cache("assets/kiss3"+ext);
		
		FlxG.sound.cache("assets/steam"+ext);
		FlxG.sound.cache("assets/wobble"+ext);
		bgColor = 0xFFFFFFFF;
		directions = new FlxSprite(155.95, 517.5);
		directions.frames = FlxAtlasFrames.fromSparrow("assets/directions.png", "assets/directions.xml");
		directions.animation.addByPrefix("idle", "dir");
		directions.animation.play("idle");
		
		
		kaya_meter = new FlxSprite(951.3, 52.4);
		kaya_meter.frames = FlxAtlasFrames.fromSparrow("assets/kaya_meter.png", "assets/kaya_meter.xml");
		kaya_meter.animation.addByPrefix("m", "kaya_meter",0);
		kaya_meter.animation.play("m",true,false,0);
		
		
		panzu = new FlxSprite(106, 51);
		kaya = new FlxSprite(246.5, -12.5);
		kaya.frames = FlxAtlasFrames.fromSparrow("assets/kaya.png", "assets/kaya.xml");
		panzu.frames = FlxAtlasFrames.fromSparrow("assets/panzu.png", "assets/panzu.xml");
		
		panzu.animation.addByPrefix("love0", "panzu_love0_", 24);
		panzu.animation.addByPrefix("kiss", "panzu_kiss", 24);
		
		for(i in 0...11){
			kaya.animation.addByPrefix("love"+i, "kaya_love"+i+"_", 24);
		}
		
		kaya.animation.addByPrefix("kissed", "kaya_kissed", 24);
		
		kaya.animation.play("love" + Math.floor(kaya_love));
		panzu.animation.play("love" + Math.floor(panzu_love));
		
		add(kaya);
		add(panzu);
		
		add(kaya_meter);
		add(directions);
		
		wobble = FlxG.sound.play("assets/wobble"+ext, 0, true);
		steam = FlxG.sound.play("assets/steam"+ext, 0, true);
		
	}
	
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.Z){
			var last = daKiss;
			while (daKiss == last){
				daKiss = FlxG.random.int(0, 3);
			}
			FlxG.sound.play("assets/kiss" + daKiss + ""+ext);
			kaya_love += 0.1;
		}
		if (kaya_love > 10) kaya_love = 10;
		if (panzu_love > 10) panzu_love = 10;
		if (FlxG.keys.pressed.Z){
			panzu.animation.play("kiss");
			kaya.animation.play("kissed");
		}else{
			panzu.animation.play("love"+Math.floor(panzu_love));
			kaya.animation.play("love"+Math.floor(kaya_love));
		}
		
		if (kaya_love >= 7 || panzu_love >= 7) wobble.volume = 1;
		if (kaya_love >= 9 || panzu_love >= 9) steam.volume = 1;
		
		
		kaya_meter.animation.play("m",true,false,Math.floor(kaya_love*10));
	}
	
}