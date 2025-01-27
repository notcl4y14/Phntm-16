package phntm.vm;

class Memory
{
	private var _data : Array<Int>;
	private var _size : Int;
	private var _length : Int;

	public var data (get, null) : Array<Int>;
	public var size (get, null) : Int;
	public var length (get, null) : Int;

	private inline function get_data () return _data;
	private inline function get_size () return _size;
	private inline function get_length () return _length;

	public function new (?size : Int)
	{
		_data = new Array();
		_size = size;
		_length = 0;
	}

	public function fill (pos : Int, len : Int, value : Int)
	{
		for (i in 0...len)
		{
			poke(pos++, value);
		}
	}

	public inline function peek (p : Int) : Int
	{
		return _data[p];
	}

	public inline function poke (p : Int, v : Int) : Int
	{
		return _data[p] = v;
	}
}