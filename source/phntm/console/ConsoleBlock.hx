package phntm.console;

class ConsoleBlock
{
	private var d : Array<Int>;
	private var l : Int;

	public var data (get, set) : Array<Int>;
	public var length (get, null) : Int;

	private inline function set_data (v) : Array<Int>
	{
		setData(v);
		return v;
	}

	private inline function get_data () : Array<Int> return d;
	private inline function get_length () : Int return l;

	public function new (data : Array<Int>)
	{
		d = data;
		l = d.length;
	}

	public function setData (data : Array<Int>)
	{
		d = data;
		l = d.length;
	}

	public function at (position : Int)
	{
		return d[position];
	}
}