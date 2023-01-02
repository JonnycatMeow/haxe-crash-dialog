package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxG;
import sys.io.File;
import sys.FileSystem;

class PlayState extends FlxState
{
	var date = 0;

	override public function create()
	{
		date = Std.int(Date.now().getTime());
		var bg = new FlxSprite(0, 0);
		bg.loadGraphic("assets/crashscreen.png");
		bg.screenCenter();
		add(bg);
		var text = new FlxText(300, 130, 690,
			Std.string(Sys.args()[0])
			+ "\n\nPlease report this to the discord server!\nPress S to save the log in \""
			+ Sys.getCwd()
			+ "crashlogs/"
			+ date
			+ ".txt\"!",
			20);
		text.setFormat("assets/comic.ttf", Math.round((36 / (Math.max(Math.min(Std.string(Sys.args()[0]).length - 350, 1) / 1.5, 1)))));
		add(text); 
		//if you want to add sound to da crash
		//FlxG.sound.playMusic("assets/game_crash_song.ogg", 1);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.SPACE)
			Sys.exit(0);
		else if (FlxG.keys.justPressed.ENTER)
			#if linux
			Sys.command('/usr/bin/xdg-open', ["https://discord.gg/VNvmegFB9k"]); 
		        #elseif mac
			Sys.command('/usr/bin/open', ["https://discord.gg/VNvmegFB9k"]); 
		        #elseif windows
			Sys.command('start', ["https://discord.gg/VNvmegFB9k"]);
			#else
			FlxG.openURL("https://discord.gg/VNvmegFB9k");
			#end
		else if (FlxG.keys.justPressed.S)
		{
			try
			{
			   if (!FileSystem.exists(Sys.getCwd() + "crashlogs/")) 
			   { 
				
				
				FileSystem.createDirectory(Sys.getCwd() + "crashlogs/");
				File.saveContent(Sys.getCwd() + "crashlogs/" + date + ".txt", Std.string(Sys.args()[0]));
				
			   }
					
			}
			catch (e)
			{
				trace("guh??? " + e); // doesnt have permission to write??
			}
		}
		super.update(elapsed);
	}
}
