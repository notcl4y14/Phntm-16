package phntm.vm;

import phntm.rendering.Display;

class Runner
{
	private var _start_position : Int;
	private var _end_position : Int;
	private var _position : Int;
	private var _memory : Memory;
	private var _stack : Array<Int>;

	private var _sections : Map<Int, Int>;
	public var display : Display;

	public var startPosition (get, null) : Int;
	public var endPosition (get, null) : Int;
	public var position (get, null) : Int;
	public var memory (get, null) : Memory;

	private inline function get_startPosition () return _start_position;
	private inline function get_endPosition () return _end_position;
	private inline function get_position () return _position;
	private inline function get_memory () return _memory;

	public function new (codeStart : Int, codeEnd : Int, memory : Memory)
	{
		_start_position = codeStart;
		_end_position = codeEnd;
		_position = codeStart;
		_memory = memory;
		_stack = new Array();
		_sections = new Map();
	}

	public function process ()
	{
		var index : Int = _start_position;

		while (index < _end_position)
		{
			var op = _memory.peek(index);

			if (op == OpCode.SECTION)
			{
				var id = _memory.peek(index + 1);
				var position = index + 4;

				_sections.set(id, position);
			}
			
			index++;
		}
	}

	public function run ()
	{
		_position = _start_position;

		while (_position < _end_position)
		{
			runOp();
		}
	}

	public function runOp ()
	{
		var op = _memory.peek(_position);

		switch (op)
		{
			case OpCode.JUMP:
				var sectionID = _memory.peek(_position + 1);
				_position = _sections.get(sectionID) - 4;

			case OpCode.POKE:
				var position = _memory.peek(_position + 1);
				var value = _memory.peek(_position + 2);

				_memory.poke(position, value);

			case OpCode.PUSH:
				var value = _memory.peek(_position + 1);
				var memory = _memory.peek(_position + 2);

				if (memory == 1)
				{
					value = _memory.peek(value);
				}

				_stack.push(value);
			
			case OpCode.POP:
				var position = _memory.peek(_position + 1);

				_memory.poke(position, _stack.pop());
			
			case OpCode.SYSCALL:
				var code = _memory.peek(_position + 1);

				switch (code)
				{
					case 0:
						var index = _stack.pop();
						var color = _stack.pop();

						display.setColorAtIndex(index, Color.getColorByID(color));
				}
			
			case OpCode.ADD | OpCode.SUB | OpCode.MUL | OpCode.DIV:
				var position = _memory.peek(_position + 1);
				var v2 = _memory.peek(_position + 2);

				var v1 = _memory.peek(position);

				switch (op)
				{
					case OpCode.ADD: v1 = v1 + v2;
					case OpCode.SUB: v1 = v1 - v2;
					case OpCode.MUL: v1 = v1 * v2;
					case OpCode.DIV: v1 = Std.int(v1 / v2);
				}

				_memory.poke(position, v1);
			
			case OpCode.COMP:
				var position = _memory.peek(_position + 1);
				var v2 = _memory.peek(_position + 2);

				var v1 = _memory.peek(position);
				
				if (v1 < v2)
				{
					_stack.push(2);
				}
				else if (v1 > v2)
				{
					_stack.push(3);
				}
				else if (v1 == v2)
				{
					_stack.push(0);
				}
				else if (v1 != v2)
				{
					_stack.push(1);
				}
				else
				{
					_stack.push(4);
				}
			
			case OpCode.JE | OpCode.JNE | OpCode.JL | OpCode.JG:
				var condition = _stack.pop();
				var isTrue = false;

				switch (op)
				{
					case OpCode.JE: isTrue = condition == 0;
					case OpCode.JNE: isTrue = condition == 1;
					case OpCode.JL: isTrue = condition == 2;
					case OpCode.JG: isTrue = condition == 3;
				}

				if (isTrue)
				{
					var sectionID = _memory.peek(_position + 1);
					_position = _sections.get(sectionID) - 4;
				}
		}

		_position = _position + 4;
	}

	public function readValue () : Any
	{
		var op = _memory.peek(_position);

		switch (op)
		{
			case OpCode.TYPE_INT:
				_position = _position + 2;
				return _memory.peek(_position - 1);
				
			case OpCode.TYPE_STR:
				var value = "";

				_position++;

				while (_position < _end_position)
				{
					if (_memory.peek(_position) == OpCode.BREAK)
						break;
					
					value = value + String.fromCharCode(_memory.peek(_position));
					_position++;
				}

				_position++;
				return value;
		}

		return null;
	}
}