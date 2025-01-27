package phntm.vm;

class PhntmVM
{
	private var _memory : Memory;

	public var memory (get, null) : Memory;

	private inline function get_memory () return _memory;

	public function new (?memorySize : Int) {
		_memory = new Memory(memorySize);
	}
}