package phntm.console;

class Console
{
	private var _code : ConsoleCode;
	private var _vars : ConsoleVarMap;
	private var _stack : ConsoleStack;

	public var code (get, null) : ConsoleCode;
	public var vars (get, null) : ConsoleVarMap;
	public var stack (get, null) : ConsoleStack;
	public var lengthCode (get, null) : Int;

	private inline function get_code () : ConsoleCode return _code;
	private inline function get_vars () : ConsoleVarMap return _vars;
	private inline function get_stack () : ConsoleStack return _stack;
	private inline function get_lengthCode () : Int return _code.length;

	public function new ()
	{
		_code  = new ConsoleCode();
		_vars  = new ConsoleVarMap();
		_stack = new ConsoleStack();
	}

	public function bindCode (code : Array<Int>)
	{
		_code.setData(code);
	}
}