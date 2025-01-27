package phntm.console;

import phntm.rendering.Display;

class ConsoleRunner
{
	private var position : Int;
	private var console : Console;

	public var section : ConsoleBlock;
	
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
		while (position < section.length)
		{
			var restart = runCommand();

			if (restart)
			{
				run();
				break;
			}
			
			step();
		}
	}

	private function runCommand () : Bool
	{
		var command : Int = section.at(position);

		switch (command)
		{
			case ConsoleCommand.MOVE:
				step();
				var _section : String = getValue();
				var _position : Int = getValue();

				section = console.code.get(_section);
				position = _position;
				return true;

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

				var c : Color = Color.getColorByID(pixelColor);

				display.setColorAtIndex(pixelIndex, c);
				step(-1);
		}

		return false;
	}

	private function getValue () : Any
	{
		var value : Any = null;

		switch (section.at(position))
		{
			case ConsoleCommand.TYPE_VAR:
				var varID = section.at(position + 1);
				value = console.vars.get(varID);
				step(2);
			
			case ConsoleCommand.TYPE_INT:
				value = section.at(position + 1);
				step(2);
			
			case ConsoleCommand.TYPE_IDENT:
				var ident : String = "";

				while (position < section.length)
				{
					step();

					if (section.at(position) == ConsoleCommand.BREAK)
					{
						break;
					}

					ident = ident + String.fromCharCode(section.at(position));
				}
				
				value = ident;
				step();
		}

		return value;
	}
}