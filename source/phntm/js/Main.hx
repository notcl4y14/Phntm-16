package phntm.js;

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
	private static var console : Console;

	public static function main () : Void
	{
		Browser.window.onresize = () -> fitCanvasToWindow();
		
		canvas = Browser.document.createCanvasElement();
		context = canvas.getContext("2d");

		Browser.document.body.appendChild(canvas);

		display = new Display(128, 128);
		display.fill(Color.WHITE);

		console = new Console();
		console.code.loadSection("main", new ConsoleBlock([
			ConsoleCommand.SET_VAR, ConsoleCommand.TYPE_INT, 0x00000000, ConsoleCommand.TYPE_INT, 10,
			ConsoleCommand.SET_VAR, ConsoleCommand.TYPE_INT, 0x00000001, ConsoleCommand.TYPE_VAR, 0x00000000,
			ConsoleCommand.OP_ADD, ConsoleCommand.TYPE_INT, 0x00000001, ConsoleCommand.TYPE_INT, 5,
			ConsoleCommand.OP_DIV, ConsoleCommand.TYPE_INT, 0x00000001, ConsoleCommand.TYPE_INT, 5,

			ConsoleCommand.SET_PIXEL, ConsoleCommand.TYPE_VAR, 0x00000001, ConsoleCommand.TYPE_INT, 0,
			ConsoleCommand.MOVE, ConsoleCommand.TYPE_IDENT, 97, ConsoleCommand.BREAK, ConsoleCommand.TYPE_INT, 0
		]));
		console.code.loadSection("a", new ConsoleBlock([
			ConsoleCommand.SET_PIXEL, ConsoleCommand.TYPE_INT, 20, ConsoleCommand.TYPE_INT, 0
		]));

		fitCanvasToWindow();
		runConsole();
		applyDisplay();

		trace(console.vars);
	}

	private static function runConsole ()
	{
		var runner : ConsoleRunner = new ConsoleRunner(console);
		runner.display = display;
		runner.section = console.code.get("main");

		runner.run();
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