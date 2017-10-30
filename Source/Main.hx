package;

import lime.audio.ExtraSoundOptions;

import openfl.display.Sprite;
import openfl.net.URLRequest;
import openfl.media.SoundChannel;
import openfl.media.Sound;

class Main extends Sprite {

	var soundInstance: SoundChannel;
	var jquery:Dynamic;
	private static var ASSET_PREFIX = "Assets/sounds/";

	public function new () {
		super ();

		untyped __js__("this.jquery = $;");
		jquery(".update").click(
			function(e) {
				var name = jquery(".name").val();
				var start = Std.int(jquery(".start").val());
				var duration = Std.int(jquery(".duration").val());
				var loop_start = Std.int(jquery(".loop_start").val());

				name = ASSET_PREFIX + name;
				updateSoundOptions(name, start, duration);
				resetSound(name);
				restartSound(name, loop_start);
			}
		);
		jquery(".stop").click(
			function(e) {
				var name = jquery(".name").val();
				name = ASSET_PREFIX + name;
				resetSound(name);
			}
		);
	}

	function updateSoundOptions(name:String, start:Int, duration:Int) {
		start = start == 0 ? null : start;
		duration = duration == 0 ? null : duration;
		@:privateAccess Reflect.field(lime.Assets.getLibrary (""), "extraSoundOptions").set(name,  new ExtraSoundOptions(start, duration, null) );
	}

	function resetSound(name:String) {
		if ( soundInstance != null ) {
			soundInstance.stop();
		}
		@:privateAccess Sound.__registeredSounds.remove(name);
	}

	function restartSound(name:String, loop_start:Int) {
		var sound = new Sound();
		sound.load(new URLRequest(name),null,null, true);
		soundInstance = sound.play(loop_start, 999999999);
	}

}
