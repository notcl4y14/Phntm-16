package phntm.js;

import js.Browser;
import phntm.rendering.Display;
import phntm.console.Console;
import phntm.console.ConsoleCommand;

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
		console.code = [
			ConsoleCommand.SET_VAR, 0xFF000000, 10,
			ConsoleCommand.SET_VAR, 0xFF000001, 0,
			ConsoleCommand.SET_PIXEL,
			ConsoleCommand.REMOVE_VAR, 0xFF000000,
			ConsoleCommand.REMOVE_VAR, 0xFF000001
		];

		fitCanvasToWindow();
		runConsole();
		applyDisplay();
	}

	private static function runConsole ()
	{
		var index = 0;

		while (index < console.code.length)
		{
			var command : Int = console.code[index];

			switch (command)
			{
				case 1:
					var pos : Int = console.code[index + 1];
					var value : Int = console.code[index + 2];

					console.setVar(pos, value);

					trace('set_var : $pos, $value');

					index += 2;
				
				case 2:
					var pos : Int = console.code[index + 1];

					console.removeVar(pos);

					trace('remove_var : $pos');

					index += 1;
				
				case 3:
					var pos : Int = console.vars.get(0xFF000000);
					var color : Int = console.vars.get(0xFF000001);

					trace("set_pixel");

					var c : Color = Color.BLACK;

					switch (color)
					{
						case 0:
							c = Color.BLACK;
						
						case 1:
							c = Color.WHITE;
					}

					display.setColorAtIndex(pos, c);
			}

			index++;
		}
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