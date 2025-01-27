package phntm;

class Color
{
	public static var BLACK : Color = new Color(0, 0, 0);
	// public static var WHITE : Color = new Color(255, 255, 255);

	public static var DARKER_BLUE : Color = new Color(26, 28, 44);
	public static var PURPLE : Color = new Color(93, 39, 93);
	public static var RED : Color = new Color(177, 62, 83);
	public static var ORANGE : Color = new Color(239, 125, 87);
	public static var YELLOW : Color = new Color(255, 205, 117);
	public static var LIME : Color = new Color(167, 240, 112);
	public static var GREEN : Color = new Color(56, 183, 100);
	public static var TEAL : Color = new Color(37, 113, 121);
	public static var DARK_BLUE : Color = new Color(41, 54, 111);
	public static var BLUE : Color = new Color(59, 93, 201);
	public static var LIGHT_BLUE : Color = new Color(65, 166, 246);
	public static var LIGHTER_BLUE : Color = new Color(115, 239, 247);
	public static var WHITE : Color = new Color(244, 244, 244);
	public static var LIGHT_GRAY : Color = new Color(148, 176, 194);
	public static var GRAY : Color = new Color(86, 108, 134);
	public static var DARK_GRAY : Color = new Color(51, 60, 87);

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

	public static function getColorByID (id : Int) : Color
	{
		switch (id % 16)
		{
			case 0: return Color.DARKER_BLUE;
			case 1: return Color.PURPLE;
			case 2: return Color.RED;
			case 3: return Color.ORANGE;
			case 4: return Color.YELLOW;
			case 5: return Color.LIME;
			case 6: return Color.GREEN;
			case 7: return Color.TEAL;
			case 8: return Color.DARK_BLUE;
			case 9: return Color.BLUE;
			case 10: return Color.LIGHT_BLUE;
			case 11: return Color.LIGHTER_BLUE;
			case 12: return Color.WHITE;
			case 13: return Color.LIGHT_GRAY;
			case 14: return Color.GRAY;
			case 15: return Color.DARK_GRAY;
			default: return Color.DARKER_BLUE;
		}
	}
}