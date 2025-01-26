package phntm.console;

class Console
{
	public var code : Array<Int>;
	public var vars : Map<Int, Int>;

	public var codeLength : Int;

	public function new ()
	{
		this.code = new Array<Int>();
		this.vars = new Map<Int, Int>();
	}

	public function setCode (code : Array<Int>)
	{
		this.code = code;
		this.codeLength = this.code.length;
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