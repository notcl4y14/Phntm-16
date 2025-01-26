package phntm.console;

class Console
{
	private var _code : Array<Int>;
	private var _vars : Map<Int, Int>;
	private var _stack : Array<Int>;

	private var _lengthCode : Int;

	public var code (get, null) : Array<Int>;
	public var vars (get, null) : Map<Int, Int>;
	public var stack (get, null) : Array<Int>;
	public var lengthCode (get, null) : Int;

	private inline function get_code () : Array<Int>
		return _code;
	private inline function get_vars () : Map<Int, Int>
		return _vars;
	private inline function get_stack () : Array<Int>
		return _stack;
	private inline function get_lengthCode () : Int
		return _lengthCode;

	public function new ()
	{
		_code  = new Array<Int>();
		_vars  = new Map<Int, Int>();
		_stack = new Array<Int>();
		_lengthCode = 0;
	}

	public function bindCode (code : Array<Int>)
	{
		_code = code;
		_lengthCode = _code.length;
	}

	public function varGet (index : Int) : Int
	{
		return _vars.get(index);
	}

	public function varSet (index : Int, value : Int)
	{
		_vars.set(index, value);
	}

	public function varDelete (index : Int)
	{
		_vars.remove(index);
	}

	public function stackPush (value : Int)
	{
		_stack.push(value);
	}

	public function stackPop () : Int
	{
		return _stack.pop();
	}
}