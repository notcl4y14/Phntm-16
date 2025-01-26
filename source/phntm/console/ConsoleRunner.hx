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
		var command : Int = console.code.at(position);

		switch (command)
		{
			case ConsoleCommand.MOVE:
				var delta : Int = console.code.at(position + 1);
				step(delta);

			case ConsoleCommand.SET_VAR:
				step();
				var varID : Int = getValue();
				var varValue : Int = getValue();

				console.vars.set( varID, varValue );
				step(-1);

			case ConsoleCommand.REMOVE_VAR:
				step();
				var varID : Int = getValue();

				console.vars.delete( varID );
				step(-1);
			
			case ConsoleCommand.STACK_PUSH:
				step();
				var value : Int = getValue();

				console.stack.push( value );
				step(-1);
			
			case ConsoleCommand.STACK_POP:
				step();
				var varID : Int = getValue();

				console.vars.set( varID, console.stack.pop() );
				step(-1);
			
			case ConsoleCommand.OP_ADD|ConsoleCommand.OP_SUB|ConsoleCommand.OP_MUL|ConsoleCommand.OP_DIV|ConsoleCommand.OP_POW:
				step();
				var v1 : Int = getValue();
				var v2 : Int = getValue();

				var varID : Int = v1;
				v1 = console.vars.get(v1);

				var value : Int = null;

				switch (command)
				{
					case ConsoleCommand.OP_ADD: value = v1 + v2;
					case ConsoleCommand.OP_SUB: value = v1 - v2;
					case ConsoleCommand.OP_MUL: value = v1 * v2;
					case ConsoleCommand.OP_DIV: value = Std.int(v1 / v2);
					case ConsoleCommand.OP_POW: value = v1 % v2;
				}
				
				console.vars.set(varID, value);
				step(-1);
			
			case ConsoleCommand.SET_PIXEL:
				step();
				var pixelIndex : Int = getValue();
				var pixelColor : Int = getValue();

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

		switch (console.code.at(position))
		{
			case ConsoleCommand.TYPE_VAR:
				var varID = console.code.at(position + 1);
				value = console.vars.get(varID);
				step(2);
			
			case ConsoleCommand.TYPE_INT:
				value = console.code.at(position + 1);
				step(2);
		}

		return value;
	}
}