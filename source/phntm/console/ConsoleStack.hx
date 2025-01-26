package phntm.console;

class ConsoleStack
{
	private var s : Array<Int>;

	public var data : Array<Int>;
	private inline function get_data () : Array<Int> return s;

	public function new ()
	{
		s = new Array<Int>();
	}

	public function clear ()
	{
		s = [];
	}

	public function push (v : Int)
	{
		s.push(v);
	}

	public function pop () : Int
	{
		return s.pop();
	}
}