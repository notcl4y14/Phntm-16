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
		while (position < console.lengthCode)
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
				
				step();
				varID = getValue();
				varValue = getValue();

				console.varSet( varID, varValue );
				step(-1);

			case ConsoleCommand.REMOVE_VAR:
				var varID : Int = console.code[position + 1];
				
				step();
				varID = getValue();

				console.varDelete( varID );
				step(-1);
			
			case ConsoleCommand.STACK_PUSH:
				var value : Int = console.code[position + 1];
				
				step();
				value = getValue();

				console.stackPush( value );
				step(-1);
			
			case ConsoleCommand.STACK_POP:
				var varID : Int = console.code[position + 1];
				
				step();
				varID = getValue();

				console.varSet( varID, console.stackPop() );
				step(-1);
			
			case ConsoleCommand.OP_ADD|ConsoleCommand.OP_SUB|ConsoleCommand.OP_MUL|ConsoleCommand.OP_DIV|ConsoleCommand.OP_POW:
				var v1 : Int = console.code[position + 1];
				var v2 : Int = console.code[position + 2];
				
				step();
				v1 = getValue();
				v2 = getValue();

				var value = 0;

				switch (command)
				{
					case ConsoleCommand.OP_ADD:
						value = console.varGet(v1) + v2;
					case ConsoleCommand.OP_SUB:
						value = console.varGet(v1) - v2;
					case ConsoleCommand.OP_MUL:
						value = console.varGet(v1) * v2;
					case ConsoleCommand.OP_DIV:
						value = Std.int(console.varGet(v1) / v2);
					case ConsoleCommand.OP_POW:
						value = console.varGet(v1) % v2;
				}
				
				console.varSet(v1, value);
				step(-1);
			
			case ConsoleCommand.SET_PIXEL:
				var pixelIndex : Int = console.code[position + 1];
				var pixelColor : Int = console.code[position + 2];
				
				step();
				pixelIndex = getValue();
				pixelColor = getValue();

				var c : Color = Color.BLACK;

				switch (pixelColor)
				{
					case 0:
						c = Color.BLACK;
					
					case 1:
						c = Color.WHITE;
				}

				display.setColorAtIndex(pixelIndex, c);
				step(-1);
		}
	}

	private function getValue () : Int
	{
		var value = null;

		switch (console.code[position])
		{
			case ConsoleCommand.TYPE_VAR:
				var varID = console.code[position + 1];
				value = console.varGet(varID);
				step(2);
			
			case ConsoleCommand.TYPE_INT:
				value = console.code[position + 1];
				step(2);
		}

		return value;
	}
}