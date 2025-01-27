package phntm.vm;

class OpCode
{
	public static var BREAK (default, never)    = 0x00000000;
	public static var SECTION (default, never)  = 0x00000001;
	
	public static var TYPE_INT (default, never) = 0x00000010;
	public static var TYPE_STR (default, never) = 0x00000011;
	
	public static var JUMP (default, never)     = 0x00000020;
	public static var POKE (default, never)     = 0x00000021;
	public static var PUSH (default, never)     = 0x00000022;
	public static var POP (default, never)      = 0x00000023;
	public static var SYSCALL (default, never)  = 0x00000024;
	public static var ADD (default, never)      = 0x00000025;
	public static var SUB (default, never)      = 0x00000026;
	public static var JUMPEQ (default, never)   = 0x00000027;
	public static var JUMPNEQ (default, never)  = 0x00000028;
}