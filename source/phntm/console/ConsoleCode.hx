package phntm.console;

class ConsoleCode
{
	private var d : Map<String, ConsoleBlock>;

	public var data (get, null) : Map<String, ConsoleBlock>;

	private inline function get_data () : Map<String, ConsoleBlock> return d;

	public function new ()
	{
		d = new Map<String, ConsoleBlock>();
	}

	public function loadSection (name : String, data : ConsoleBlock)
	{
		d.set(name, data);
	}

	public function get (name : String)
	{
		return d.get(name);
	}
}