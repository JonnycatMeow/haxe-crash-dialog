package;

import Sys.sleep;
import flixel.FlxGame;
import openfl.display.Sprite;
import discord_rpc.DiscordRpc;
import lime.app.Application;

class Main extends Sprite
{
	public function new()
	{
		super();
		if (Sys.args()[0] == null || Sys.args()[1] == null)
			Sys.exit(0);
		#if (flixel >= "5.0.0")
		addChild(new FlxGame(0, 0, PlayState, 60, 60, true));
		#else
		addChild(new FlxGame(0, 0, PlayState, 1, 60, 60, true));
		#end
		#if desktop
		DiscordClient.initialize();
		Application.current.onExit.add(function(exitCode)
		{
			DiscordClient.shutdown();
		});
		#end
	}
}

class DiscordClient
{
	public function new()
	{
		DiscordRpc.start({
			clientID: "947491677742972968",
			onReady: onReady,
			onError: onError,
			onDisconnected: onDisconnected
		});

		while (true)
		{
			DiscordRpc.process();
			sleep(2);
		}

		DiscordRpc.shutdown();
	}

	public static function shutdown()
	{
		DiscordRpc.shutdown();
	}

	static function onReady()
	{
		DiscordRpc.presence({
			details: Sys.args()[1],
			state: "In the Crash Handler",
			largeImageKey: 'icon',
			largeImageText: "Dave and Bambi's Occurrence"
		});
	}

	static function onError(_code:Int, _message:String)
	{
		trace('Error! $_code : $_message');
	}

	static function onDisconnected(_code:Int, _message:String)
	{
		trace('Disconnected! $_code : $_message');
	}

	public static function initialize()
	{
		var DiscordDaemon = sys.thread.Thread.create(() ->
		{
			new DiscordClient();
		});
	}
}
