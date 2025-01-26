package phntm.console;

import phntm.rendering.Display;

class ConsoleRunner
{
	private var position : Int;
	private var console : Console;
	
	public var display : Display;

	public function new (console : Console)
	{
		this.position = 0;
		this.console = console;
	}

	private function getCommand (delta : Int = 0)
	{
		return console.code[position + delta];
	}

	private function step (delta : Int = 1)
	{
		position += delta;
	}

	public function run ()
	{
		while (position < console.codeLength)
		{
			runCommand();
			step();
		}
	}

	private function runCommand ()
	{
		var command : Int = console.code[position];

		switch (command)
		{
			case ConsoleCommand.MOVE:
				var delta : Int = getCommand(1);
				step(delta);
			case ConsoleCommand.SET_VAR:
				var varID : Int = console.code[position + 1];
				var varValue : Int = console.code[position + 2];

				console.setVar(varID, varValue);
				step(2);

			case ConsoleCommand.REMOVE_VAR:
				var varID : Int = console.code[position + 1];

				console.removeVar(varID);
				step();
			
			case ConsoleCommand.SET_PIXEL:
				var pixelIndex : Int = console.code[position + 1];
				var pixelColor : Int = console.code[position + 2];

				var c : Color = Color.BLACK;

				switch (pixelColor)
				{
					case 0:
						c = Color.BLACK;
					
					case 1:
						c = Color.WHITE;
				}

				display.setColorAtIndex(pixelIndex, c);
				step(2);
		}
	}
}