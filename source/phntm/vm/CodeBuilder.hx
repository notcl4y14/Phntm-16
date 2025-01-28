package phntm.vm;

class CodeBuilder
{
	public var code : Array<Int>;

	public function new () {
		code = new Array();
	}

	public function add (a : Int, b : Int, c : Int, d : Int)
	{
		code.push(a);
		code.push(b);
		code.push(c);
		code.push(d);
	}

	public function put (arr : Array<Int>, pos : Int)
	{
		var length : Int = code.length;
		var index : Int = 0;

		while (index < length)
		{
			arr[index + pos] = code[index];
			index++;
		}
	}
}