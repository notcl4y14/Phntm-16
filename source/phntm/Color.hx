package phntm;

class Color
{
	public static var BLACK : Color = new Color(0, 0, 0);
	public static var WHITE : Color = new Color(255, 255, 255);

	public var r : Int;
	public var g : Int;
	public var b : Int;
	public var a : Int;

	public function new (r : Int, g : Int, b : Int, a : Int = 255)
	{
		this.r = r;
		this.g = g;
		this.b = b;
		this.a = a;
	}

	public static function getByIndex (color : Color, index : Int) : Int
	{
		switch (index % 4)
		{
			case 0: return color.r;
			case 1: return color.g;
			case 2: return color.b;
			case 3: return color.a;
			default: return 0;
		}
	}
}