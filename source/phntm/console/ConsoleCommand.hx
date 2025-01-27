package phntm.console;

class ConsoleCommand
{
	public static var BREAK (default, never)      : Int = 0x00000000;
	public static var MOVE (default, never)       : Int = 0x00000001;
	public static var SET_VAR (default, never)    : Int = 0x00000002;
	public static var REMOVE_VAR (default, never) : Int = 0x00000003;
	public static var STACK_PUSH (default, never) : Int = 0x00000004;
	public static var STACK_POP (default, never)  : Int = 0x00000005;
	public static var TYPE_NULL (default, never)  : Int = 0x00001000;
	public static var TYPE_VAR (default, never)   : Int = 0x00001001;
	public static var TYPE_INT (default, never)   : Int = 0x00001002;
	public static var TYPE_IDENT (default, never) : Int = 0x00001003;
	public static var OP_ADD (default, never)     : Int = 0x00002000;
	public static var OP_SUB (default, never)     : Int = 0x00002001;
	public static var OP_MUL (default, never)     : Int = 0x00002002;
	public static var OP_DIV (default, never)     : Int = 0x00002003;
	public static var OP_POW (default, never)     : Int = 0x00002004;
	public static var SET_PIXEL (default, never)  : Int = 0x00003000;
}