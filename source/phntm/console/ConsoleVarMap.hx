package phntm.console;

class ConsoleVarMap
{
	private var v : Map<Int, Int>;

	public var data (get, null) : Map<Int, Int>;
	public inline function get_data () : Map<Int, Int> return v;

	public function new ()
	{
		v = new Map<Int, Int>();
	}

	public function get (position : Int) : Int
	{
		return data[position];
	}

	public function set (position : Int, value : Int)
	{
		data[position] = value;
	}

	public function delete (position : Int)
	{
		data.remove(position);
	}
}