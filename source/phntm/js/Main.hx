package phntm.js;

import phntm.vm.OpCode;
import phntm.vm.Runner;
import phntm.vm.PhntmVM;
import js.Browser;
import phntm.rendering.Display;
import phntm.console.Console;
import phntm.console.ConsoleBlock;
import phntm.console.ConsoleCommand;
import phntm.console.ConsoleRunner;

class Main
{
	private static var canvas : js.html.CanvasElement;
	private static var context : js.html.CanvasRenderingContext2D;

	private static var display : Display;
	private static var console : PhntmVM;
	// private static var console : Console;

	public static function main () : Void
	{
		Browser.window.onresize = () -> fitCanvasToWindow();
		
		canvas = Browser.document.createCanvasElement();
		context = canvas.getContext("2d");

		Browser.document.body.appendChild(canvas);

		display = new Display(128, 128);
		display.fill(Color.DARKER_BLUE);

		console = new PhntmVM(0xffff);
		console.memory.fill(0, console.memory.size, 0x0);

		console.memory.poke(0x8000, OpCode.JUMP);
		console.memory.poke(0x8001, 97);
		console.memory.poke(0x8002, 0x0);
		console.memory.poke(0x8003, 0x0);

		console.memory.poke(0x8004, OpCode.SECTION);
		console.memory.poke(0x8005, 97);
		console.memory.poke(0x8006, 0x0);
		console.memory.poke(0x8007, 0x0);
		
		console.memory.poke(0x8008, OpCode.PUSH);
		console.memory.poke(0x8009, 0x0);
		console.memory.poke(0x800a, 0x1);
		console.memory.poke(0x800b, 0x0);
		console.memory.poke(0x800c, OpCode.PUSH);
		console.memory.poke(0x800d, 0x0);
		console.memory.poke(0x800e, 0x1);
		console.memory.poke(0x800f, 0x0);
		console.memory.poke(0x8010, OpCode.SYSCALL);
		console.memory.poke(0x8011, 0x0);
		console.memory.poke(0x8012, 0x0);
		console.memory.poke(0x8013, 0x0);

		console.memory.poke(0x8014, OpCode.ADD);
		console.memory.poke(0x8015, 0x0);
		console.memory.poke(0x8016, 3);
		console.memory.poke(0x8017, 0x0);

		console.memory.poke(0x8018, OpCode.JUMPLE);
		console.memory.poke(0x8019, 97);
		console.memory.poke(0x801a, 0x0);
		console.memory.poke(0x801b, 128 * 128);

		var runner = new Runner(0x8000, 0xffff, console.memory);
		runner.display = display;
		runner.process();
		runner.run();

		trace(runner);

		fitCanvasToWindow();
		applyDisplay();
	}

	private static function runConsole ()
	{
		// var runner : ConsoleRunner = new ConsoleRunner(console);
		// runner.display = display;
		// runner.section = console.code.get("main");

		// runner.run();
	}

	private static function applyDisplay ()
	{
		var displayDim = display.getSize();
		var index = -1;

		var scaleX : Int = Std.int(canvas.width / displayDim[0]);
		var scaleY : Int = Std.int(canvas.height / displayDim[1]);

		while (++index < display.getArea())
		{
			var x : Int = index % displayDim[0];
			var y : Int = Std.int(index / displayDim[0]);
			var color : Color = display.getColor(x, y);

			context.fillStyle = 'rgba(${color.r}, ${color.g}, ${color.b}, ${color.a})';
			context.fillRect(x * scaleX, y * scaleY, scaleX, scaleY);
		}
	}

	private static function fitCanvasToWindow ()
	{
		var widthScale = Browser.window.innerWidth / 128;
		var heightScale = Browser.window.innerHeight / 128;
		var scale = Math.min(widthScale, heightScale);

		var left = Browser.window.innerWidth / 2 - (128 * scale) / 2;
		var top = Browser.window.innerHeight / 2 - (128 * scale) / 2;

		var width : Int = Std.int(128 * scale);
		var height : Int = Std.int(128 * scale);

		// Subtract by 1 if the width/height value is odd.
		width = width - width % 2;
		height = height - height % 2;

		canvas.width = width;
		canvas.height = height;

		canvas.style.left = '${left}px';
		canvas.style.top = '${top}px';
		canvas.style.width = '${width}px';
		canvas.style.height = '${height}px';
	}
}