package phntm.console;

class Console
{
	public var code : Array<Int>;
	public var vars : Map<Int, Int>;

	public function new () {
		this.code = new Array<Int>();
		this.vars = new Map<Int, Int>();
	}

	public function setVar (index : Int, value : Int)
	{
		this.vars.set(index, value);
	}

	public function removeVar (index : Int)
	{
		this.vars.remove(index);
	}
}