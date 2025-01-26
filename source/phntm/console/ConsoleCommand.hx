package phntm.console;

class ConsoleCommand
{
	public static var BREAK (default, never)      : Int = 0x00000000;
	public static var MOVE (default, never)       : Int = 0x00000001;
	public static var SET_VAR (default, never)    : Int = 0x00000002;
	public static var REMOVE_VAR (default, never) : Int = 0x00000003;
	public static var SET_PIXEL (default, never)  : Int = 0x00001000;
}