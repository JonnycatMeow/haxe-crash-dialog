# crash handler dnb occ version
made by dnb occ team

# how to compile  
 to compile do lime build linux or windows or mac 
 
 # how to add the crash handler 
 
 1. add this code on Main.hx.  
 
  static function onCrash(e:UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
			}
		}

		errMsg += "\nUncaught Error: " + e.error + "\n";

		var crashDialoguePath:String = "OccurrenceCrashHandler";

		#if windows
		crashDialoguePath += ".exe";
		#end

		new Process(crashDialoguePath, [errMsg, e.error]);
		Sys.exit(1);
	}
 
