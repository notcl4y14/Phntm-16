package phntm.rendering;

class Display
{
	private var colors : Array<Int>;
	private var area : Int;
	private var width : Int;
	private var height : Int;

	public function new (width : Int, height : Int)
	{
		this.colors = new Array<Int>();
		this.area = width * height;
		this.width = width;
		this.height = height;
	}

	public inline function getColors () : Array<Int>
		return this.colors;

	public inline function getArea () : Int
		return this.area;

	public inline function getSize () : Array<Int>
		return [this.width, this.height];

	public function setColor (x : Int, y : Int, color : Array<Int>)
	{
		var index = (y * this.width + x) * 4;
		this.colors[index] = color[0];
		this.colors[index + 1] = color[1];
		this.colors[index + 2] = color[2];
		this.colors[index + 3] = color[3];
	}

	public function getColor (x : Int, y : Int) : Array<Int>
	{
		var index = (y * this.width + x) * 4;
		return [
			this.colors[index],
			this.colors[index + 1],
			this.colors[index + 2],
			this.colors[index + 3]
		];
	}

	public function fill (color : Array<Int>)
	{
		var index = -1;

		while (++index < this.area)
		{
			this.colors[index] = color[index % 4];
		}
	}
}